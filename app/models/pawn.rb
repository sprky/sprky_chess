class Pawn < Piece
  def legal_move?(x, y)
    return false if backwards_move?(y)

    unless capture_move?(x, y)
      return false if horizontal_move?(x) ||
                      game.obstruction(x, y)
    end

    proper_length?(y)
  end

  def capture_move?(x, y)
    x_diff = (x_position - x).abs
    y_diff = (y_position - y).abs
    captured_piece = game.obstruction(x, y)

    return false if captured_piece.blank?
    return false if captured_piece.color == color

    captured_piece ? (x_diff == 1) && (y_diff == 1) : false
  end

  def obstructed_move?(x, y)
    # check if a white 2 square move with obstruction
    return true if y_position == 1 && y == 3 && game.obstruction(x, 2)
    # check if a black 2 square move with obstruction
    return true if y_position == 6 && y == 4 && game.obstruction(x, 5)
    false
  end

  def pawn_can_promote?(y)
    puts "OK"
    puts "#{y}"
    if y == 7 || y == 0
      return true
    else
      return false
    end
  end

  def pawn_promotion
    x=x_position
    y=y_position
    color=pawn.color
    update_attributes(x_position: nil, y_position: nil)
    Queen.create(game_id: id, x_position: x, y_position: y, color: color)
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
end
