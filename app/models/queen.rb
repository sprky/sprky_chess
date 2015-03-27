class Queen < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y ||
      (x_position - x).abs == (y_position - y).abs
  end

  def obstructed_move?(x, y)
    obstructed_diagonally?(x, y) || obstructed_rectilinearly?(x, y)
  end
end
