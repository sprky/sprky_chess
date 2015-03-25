class King < Piece
	def legal_move?(x, y)
    proper_length?(x, y)
  end

  def obstructed_move?(x, y)
    # king moves one space - can't be obstructed
    false
  end
end

private

def proper_length?(x, y)
  x_diff = (x - x_position).abs
  y_diff = (y - y_position).abs

  (x_diff <= 1) && (y_diff <= 1)
end