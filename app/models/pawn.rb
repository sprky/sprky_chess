require 'byebug'
class Pawn < Piece
  def legal_move?(x, y)
    # if move_obstructed?
      # if one space diagonal-left || one space diagonal-right
        # return true
      # end
    # else

      vertical_diff = (y - self.y_position).abs

      # is it the pawn's first move?
      if (self.y_position == 1) || (self.y_position == 6)
        # check if move is one or two spaces
        (vertical_diff == (1 || 2)) ? true : false

          # should the pawn register that it moved 2 spaces on its first move in order to setup conditions for en_passant?

      else
        vertical_diff == 1 ? true : false
      end

      # is it en_passant?
        # if meets en_passant conditions
          # true
        # end
      # else
        # false
      # end 

    # end (from move_obstructed )
  end

end