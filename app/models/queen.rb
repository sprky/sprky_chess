class Queen < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y ||
      (x_position - x).abs == (y_position - y).abs
  end
end