class Bishop < Piece
  def legal_move?(x, y)
    (x_position - x).abs == (y_position - y).abs
  end

  def obstructed_move?(x, y)
    obstructed_diagonally?(x, y)
  end
end
