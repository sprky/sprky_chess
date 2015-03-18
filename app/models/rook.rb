class Rook < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y
  end

  # obstructed_move?(x,y) implementation for a rook
  # given x, y integer(0-7) for destination
  # pos_x, pos_y are current locations of piece (self)
  # determine if move is horizontal or vertical
  # then determine left/right or up/down
  # iterate from pos_x, pos_y to 1 square before x,y.
  # Then check x, y for obstruction or capture (returns false but 
  # marks captured piece.) If a single obstruction is
  # found, immediately return true.  By default, lack
  # of any obstruction will return false.

  def obstructed_move?(x, y)
    
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