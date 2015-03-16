require 'byebug'
class Pawn < Piece
  def legal_move?(x, y)
    # if move_obstructed?
      # if one space diagonal-left || one space diagonal-right
        # return true
      # end
    # else

      return false if backwards_move?(y)
      proper_length?(y)

    # end (from move_obstructed )
  end

  private

  def backwards_move?(y)
    color ? y_position > y : y_position < y   
  end

  def first_move?(y)
    (y_position == 1 && color) || (y_position == 6 && !color)
  end

  def proper_length?(y)
    y_diff = (y - y_position).abs
    first_move?(y) ? y_diff == (1 || 2) : y_diff == 1
  end

end