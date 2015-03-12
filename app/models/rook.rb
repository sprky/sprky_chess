class Rook < Piece
  def legal_move?(x, y)
    # if the move is vertical or horizontal, assume true,
    if self.x_position == x || self.y_position == y
      return true
    else false

    end 
  end
end