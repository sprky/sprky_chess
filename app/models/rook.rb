class Rook < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y
  end
  
  def obstructed_move?(x, y)
    obstructed_rectilinearly?(x, y)
  end
end