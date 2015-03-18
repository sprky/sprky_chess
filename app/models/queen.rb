class Queen < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y ||
      (x_position - x).abs == (y_position - y).abs
  end

  def obstructed_move?(x, y)
    
    return true if obstructed_diagonally?(x, y)
    return true if obstructed_rectilinearly?(x, y)
    
    # capture logic  - I think this can get refactored into a method used by all the pieces except pawn
    destination_obstruction = game.obstruction(x, y) # is there something at the destination?
    if destination_obstruction && destination_obstruction.color == self.color
      # yes and it's the same color - it's an obstruction
      return true
    elsif destination_obstruction && destination_obstruction.color != self.color
      # yes but it's a different color - capture it
      # destination_obstruction.mark_captured
      return false # no obstruction, piece should move there.
    end
    
    return false 
  end
end