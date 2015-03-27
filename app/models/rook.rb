class Rook < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y
  end
  
  def obstructed_move?(x, y)
    obstructed_rectilinearly?(x, y)
  end

  # used to find the correct rook or castling
  # passes a king and a side string ["King","Queen"]
  # returns the appropriate rook

end