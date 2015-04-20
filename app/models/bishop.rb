class Bishop < Piece
  def legal_move?(x, y)
    (x_position - x).abs == (y_position - y).abs
  end

  def obstructed_squares(x, y)
    diagonal_obstruction_array(x, y)
  end
end
