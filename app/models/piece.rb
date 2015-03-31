class Piece < ActiveRecord::Base
  MIN_BOARD_SIZE = 0
  MAX_BOARD_SIZE = 7

  after_initialize :set_default_images
  after_initialize :set_default_state

  belongs_to :player
  belongs_to :game

  include Obstructions

  def valid_move?(x, y)
    # check to make sure move isn't back to same spot
    return false if nil_move?(x, y)

    return false unless move_on_board?(x, y)

    return false unless moving_own_piece?

    return false unless legal_move?(x, y)

    return false if obstructed_move?(x, y)

    return false if destination_obstructed?(x, y)

    # check that the move doesn't put the king into check
    # return false if move_causes_check?(x, y)

    true
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

  def mark_captured
    update_attributes(x_position: nil, y_position: nil, state: 'captured')
  end

  def move_on_board?(x, y)
    (x <= MAX_BOARD_SIZE && x >= MIN_BOARD_SIZE) && (y <= MAX_BOARD_SIZE && y >= MIN_BOARD_SIZE)
  end

  def move_to(piece, params)
    x = params[:x_position].to_i
    y = params[:y_position].to_i

    if piece.valid_move?(x, y)
      if capture_move?(x, y)
        captured = game.obstruction(x, y)
        captured.mark_captured
      end
      if piece.type == 'King' && piece.legal_castle_move?(x, y)
        piece.castle_move
      else
        piece.update_attributes(x_position: x, y_position: y, state: 'moved')
        switch_players
      end
    end
  end

  def nil_move?(x, y)
    x_position == x && y_position == y
  end

  def obstructed_move?(_x, _y)
    fail NotImplementedError 'Pieces must implement #obstructed_move?'
  end

  def switch_players
    if player_id == game.white_player_id
      game.update_attributes(turn: game.black_player_id)
    else
      game.update_attributes(turn: game.white_player_id)
    end
  end

  def moving_own_piece?
    player_id == game.turn
  end

  private

  def set_default_images
    self.symbol ||= "#{color_name}-#{type.downcase}.gif"
  end

  def set_default_state
    self.state ||= 'unmoved'
  end
end
