class Piece < ActiveRecord::Base
  MIN_BOARD_SIZE = 0
  MAX_BOARD_SIZE = 7

  after_initialize :set_default_images
  after_initialize :set_default_state

  belongs_to :player
  belongs_to :game

  # include obstructions concern for obstruction related methods
  include Obstructions

  # use transactions to attempt a move, fail and rollback if move
  # puts player into check
  def attempt_move(params)
    Piece.transaction do
      return false unless moving_own_piece?
      fail ActiveRecord::Rollback unless move_to(params)
      fail ActiveRecord::Rollback if game.check?(color)

      # update current state of check, checkmate, etc.
      game.update_state(color)
    end
  end

  # method to determine if an opposing piece can block check
  # this method is called to determine checkmate.
  def can_be_blocked?(king)
    # get all possible squares that could be used to obstruct check
    obstruction_array = obstructed_squares(king.x_position, king.y_position)

    opponents = game.pieces_remaining(!color)
    # for each opponent, iterate through all squares that could obstruct
    opponents.each do |opponent|
      next if opponent.type == 'King'
      obstruction_array.each do |square|
        # return true if we find even one way to obstruct check
        return true if opponent.valid_move?(square[0], square[1])
      end
    end
    false
  end

  # method to determine if a piece can be captured.
  # called to determine checkmate
  def can_be_captured?
    opponents = game.pieces_remaining(!color)
    opponents.each do |opponent|
      # for each opponent, see if the checking piece can be captured
      if opponent.valid_move?(x_position, y_position)
        return true
      end
    end
    false
  end

  # determine a move is a capture move
  def capture_move?(x, y)
    captured_piece = game.obstruction(x, y)
    captured_piece && captured_piece.color != color
  end

  def color_name
    color ? 'white' : 'black'
  end

  # determines whether move follows the legal move pattern for a given piece type
  def legal_move?(_x, _y)
    fail NotImplementedError 'Pieces must implement #legal_move?'
  end

  # determine if player_id of piece matches current turn
  def moving_own_piece?
    player_id == game.turn
  end

  def move_on_board?(x, y)
    (x <= MAX_BOARD_SIZE && x >= MIN_BOARD_SIZE) &&
      (y <= MAX_BOARD_SIZE && y >= MIN_BOARD_SIZE)
  end

  # this method carries out the movement of a piece and determines if there is also a
  # capture involved. Both king and pawn override this method to carry out special moves
  def move_to(params)
    x = params[:x_position].to_i
    y = params[:y_position].to_i

    if valid_move?(x, y)
      if capture_move?(x, y)
        captured = game.obstruction(x, y)
        captured.update_piece(nil, nil, 'off-board')
      end

      # clear any previous en passant states
      game.clear_en_passant(color)

      if type == 'Pawn' && en_passant?(y)
        update_piece(x, y, 'en_passant')
      else
        update_piece(x, y, 'moved')
      end
      return true
    end
    false
  end

  def nil_move?(x, y)
    x_position == x && y_position == y
  end

  # this method collects an array of squares where an obstruction could occur
  # the checks each of those squares for any obstructing piece
  def obstructed_move?(x, y)
    obstruction_array = obstructed_squares(x, y)

    return false if obstruction_array.empty?

    obstruction_array.each do |square|
      # return true if we find an obstruction
      return true if game.obstruction(square[0], square[1])
    end

    # default to false
    false
  end

  def update_piece(x, y, state)
    update_attributes(x_position: x, y_position: y, state: state)
  end

  # determine squares between current position and _x, _y. Method overridden
  # by each piece.
  def obstructed_squares(_x, _y)
    fail NotImplementedError 'Pieces must implement #obstructed_squares'
  end

  # determine if a move is valid
  def valid_move?(x, y)
    return false if nil_move?(x, y)
    return false unless move_on_board?(x, y)
    return false unless legal_move?(x, y)
    return false if obstructed_move?(x, y)
    return false if destination_obstructed?(x, y)
    true
  end

  private

  def set_default_images
    self.symbol ||= "#{color_name}-#{type.downcase}.svg"
  end

  def set_default_state
    self.state ||= 'unmoved'
  end
end
