class Pawn < Piece
  
  def legal_move?(x, y)

    x_diff = (x_position - x).abs

    if x_diff.zero?  
      return false if backwards_move?(y)
      proper_length?(y)
    elsif x_diff == 1
      #  check for capture move
      return false
      # end
    else  # otherwise has illegal horizontal component
      return false
    end
    
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