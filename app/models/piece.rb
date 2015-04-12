class Piece < ActiveRecord::Base
  MIN_BOARD_SIZE = 0
  MAX_BOARD_SIZE = 7

  after_initialize :set_default_images
  after_initialize :set_default_state

  belongs_to :player
  belongs_to :game

  include Obstructions

  def attempt_move(piece, params)
    Piece.transaction do
      move_to(piece, params)
      game = piece.game
      game.update_attributes(state: nil)
      if game.check?(color)
        fail ActiveRecord::Rollback
      end
    end
  end

  def capture_move?(x, y)
    captured_piece = game.obstruction(x, y)
    captured_piece && captured_piece.color != color
  end

  def color_name
    color ? 'white' : 'black'
  end

  def can_escape_check?
    Piece.transaction do
      game = piece.game
      game.update_attributes(state: 'check')

      # Somehow loop through all possible moves
      move_to(self, x_position: _, y_position: _)
      # If after any of the moves, game is no longer in check
      return true if !game.check?(color)

      ActiveRecord::Rollback
    end
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
      game.switch_players(player_id)
      game.update_attributes(state: 'check') if game.check?(!color)
    end
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

    # check that the move doesn't put the king into check
    # return false if move_causes_check?(x, y) - pull this out of valid_move?

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
