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
    
    obstructed_rectilinearly?(x, y)
    
  end
end