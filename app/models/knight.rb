class Knight < Piece
	def legal_move?(x, y)
    return false if x_position == x
    return false if y_position == y
    proper_length?(x, y)
  end

  def obstructed_move?(x, y)
    
    destination_obstruction = game.obstruction(x, y)
    if destination_obstruction && destination_obstruction.color == self.color
      # yes and it's the same color - it's an obstruction
      return true

      # can include else and capture logic here
    end

    return false 
  end

  private

  def proper_length?(x, y)
    (x_position - x).abs + (y_position - y).abs == 3
  end

end