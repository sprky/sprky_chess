class Bishop < Piece
	def legal_move?(x, y)
    (x_position - x).abs == (y_position - y).abs
  end
end