require 'byebug'

class Pawn < Piece
  
  def legal_move?(x, y)
    # if move_obstructed?
      # if one space diagonal-left || one space diagonal-right
        # return true
      # end
    # else
    x_diff = (x_position - x).abs

    # ensure x-value didn't change
    if x_diff.zero? 
      puts "backwards_move  #{backwards_move?(y)}"
      
      return false if backwards_move?(y)
      
      puts "proper_length #{proper_length?(y)}"
      proper_length?(y)
    elsif x_diff == 1
      # did it change by 1 check for capture
      #  check for capture move
      puts "check captured"
      return false
      # end
    else  # otherwise has illegal horizontal component
      puts "horizontal"
      return false
    end
    
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
    first_move?(y) ? (y_diff == 1 || y_diff == 2) : y_diff == 1
  end

end