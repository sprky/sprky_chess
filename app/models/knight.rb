class Knight < Piece
	def legal_move?(x, y)
    return false if diagonal_move?(x, y)
    return false if x_position == x
    return false if y_position == y
    proper_length?(x, y)
  end

  private

  def diagonal_move?(x, y)
   (x_position - x).abs == (y_position - y).abs
  end

  def proper_length?(x, y)
    x_diff = (x_position - x).abs
    y_diff = (y_position - y).abs

    (x_diff == 2) && (y_diff == 1) || (y_diff == 2) && (x_diff == 1)
  end

end