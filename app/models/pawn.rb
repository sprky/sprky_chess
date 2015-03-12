class Pawn < Piece
  def legal_move?(x, y)
    # is move_obstructed?
      # if one space diagonal-left || one space diagonal-right
        # return true
      # end
      # false

    # is it the pawn's first move?
      # if one space forward || two spaces forward
        # true 
      # end
      # false

    # is it en_passant?
      # if meets en_passant conditions
        # true
      # end
      # false
    false
  end

end