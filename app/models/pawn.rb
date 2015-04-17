class Pawn < Piece
  def legal_move?(x, y)
    return false if backwards_move?(y)

    unless capture_move?(x, y)
      return false if horizontal_move?(x) || game.obstruction(x, y)
    end

    proper_length?(y)
  end

  def move_to(piece, params)
    x = params[:x_position].to_i
    y = params[:y_position].to_i

    if can_promote?(y) && valid_move?(x, y)
      promotion(x, y)
    else
      super(piece, params)
    end
  end

  def capture_move?(x, y)
    x_diff = (x_position - x).abs
    y_diff = (y_position - y).abs
    captured_piece = game.obstruction(x, y)

    return false if captured_piece.blank?
    return false if captured_piece.color == color

    captured_piece ? (x_diff == 1) && (y_diff == 1) : false
  end

  def obstructed_squares(x, y)
    # check if a white 2 square move with obstruction
    return [[x, 2]] if y_position == 1 && y == 3
    # check if a black 2 square move with obstruction
    return [[x, 5]] if y_position == 6 && y == 4

    []
  end

  def can_promote?(y)
    y == 7 && color || y == 0 && !color
  end

  def promotion(x, y)
    update_attributes(
      x_position: nil,
      y_position: nil,
      state: 'captured')
    Queen.create(
      game_id: game_id,
      x_position: x,
      y_position: y,
      player_id: player_id,
      color: color)
  end

  private

  def horizontal_move?(x)
    x_diff = (x_position - x).abs
    x_diff != 0
  end

  def backwards_move?(y)
    color ? y_position > y : y_position < y
  end

  def first_move?(_y)
    (y_position == 1 && color) || (y_position == 6 && !color)
  end

  def proper_length?(y)
    y_diff = (y - y_position).abs
    first_move?(y) ? (y_diff == 1 || y_diff == 2) : y_diff == 1
  end

  def x_scope
    1
  end

  def y_scope
    2
  end
end
