class Bishop < Piece
	def legal_move?(x, y)
    (x_position - x).abs == (y_position - y).abs
  end

  def obstructed_move?(x,y)
  	return true if obstructed_diagonally?(x, y)
    
    return false
  end
end