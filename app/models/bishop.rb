class Bishop < Piece
	def legal_move?(x, y)
    # add bishop-specific legal_move? logic here
    x_diff = (x_position - x).abs
    y_diff = (y_position - y).abs

    x_diff == y_diff ? true : false
  end
end