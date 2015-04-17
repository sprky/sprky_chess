require 'byebug'

class Piece < ActiveRecord::Base
  MIN_BOARD_SIZE = 0
  MAX_BOARD_SIZE = 7

  after_initialize :set_default_images
  after_initialize :set_default_state

  belongs_to :player
  belongs_to :game

  include Obstructions

  # use transactions to attempt a move, fail and rollback if move
  # puts player into check
  def attempt_move(piece, params)
    Piece.transaction do
      move_to(piece, params) if moving_own_piece?
      if game.check?(color)
        fail ActiveRecord::Rollback
      end
      # update current state of check, checkmate, etc.
      game.update_state(color)
    end
  end

  def can_be_blocked?(king)
    obstruction_array = obstructed_squares(king.x_position, king.y_position)

    blockers = game.pieces_remaining(!color)
    blockers.each do |blocker|
      obstruction_array.each do |square|
        # return true if we find an obstruction
        return true if blocker.valid_move?(square[0], square[1])
      end
    end
    false
  end

  def can_be_captured?
    opponents = game.pieces.where("color = ? and state != 'captured'", !color).to_a
    opponents.each do |opposing_piece|
      if opposing_piece.valid_move?(x_position, y_position)
        return true
      end
    end
    false
  end

  def capture_move?(x, y)
    captured_piece = game.obstruction(x, y)
    captured_piece && captured_piece.color != color
  end

  def color_name
    color ? 'white' : 'black'
  end

  def legal_move?(_x, _y)
    fail NotImplementedError 'Pieces must implement #legal_move?'
  end

  def moving_own_piece?
    player_id == game.turn
  end

  def move_on_board?(x, y)
    (x <= MAX_BOARD_SIZE && x >= MIN_BOARD_SIZE) &&
      (y <= MAX_BOARD_SIZE && y >= MIN_BOARD_SIZE)
  end

  def move_to(piece, params)
    x = params[:x_position].to_i
    y = params[:y_position].to_i

    if piece.valid_move?(x, y)
      if capture_move?(x, y)
        captured = game.obstruction(x, y)
        captured.update_piece(nil, nil, 'captured')
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

  def obstructed_squares(_x, _y)
    fail NotImplementedError 'Pieces must implement #obstructed_squares'
  end

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
