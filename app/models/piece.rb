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
      move_to(piece, params)
      if game.check?(color)
        fail ActiveRecord::Rollback
      end
      # update current state of check, checkmate, etc.
      game.update_state(color)
    end
  end

  def capture_move?(x, y)
    captured_piece = game.obstruction(x, y)
    captured_piece && captured_piece.color != color
  end

  def color_name
    color ? 'white' : 'black'
  end

  # check to see if piece can escape check by his own move
  # should this be a piece only method?
  def can_escape_check?
    @escaped_by_moving = false
    # iterate x and y position of piece through all possible move locations
    (-x_scope..x_scope).each do |x|
      (-y_scope..y_scope).each do |y|
        Piece.transaction do
          # debugging
          # puts "x#{x}"
          # puts "y#{y}"

          # # make sure it's self's turn before trying to move
          # game.update_attributes(turn: player_id)

          # try to move piece into that position.  If it won't move go to
          # next interation - note move_to returns true or false
          next unless move_to(
            self,
            x_position: (x_position + x),
            y_position: (y_position + y))

          # puts "move#{game.turn}"

          # check to see if this move gets king out of check.
          @escaped_by_moving = true unless game.check?(color)
          # puts "Escaped? #{@escaped_by_moving}"

          # roll back these moves
          fail ActiveRecord::Rollback
        end
      end
    end
    @escaped_by_moving
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

      update_piece(x, y, 'moved')
      return true
    end

    false
  end

  def nil_move?(x, y)
    x_position == x && y_position == y
  end

  def obstructed_move?(_x, _y)
    fail NotImplementedError 'Pieces must implement #obstructed_move?'
  end

  def update_piece(x, y, state)
    update_attributes(x_position: x, y_position: y, state: state)
  end

  def valid_move?(x, y)
    return false if nil_move?(x, y)
    return false unless move_on_board?(x, y)
    return false unless moving_own_piece?
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
