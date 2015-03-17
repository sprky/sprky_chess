class Rook < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y
  end

  # obstructed_move?(x,y) implementation for a rook
  # given x, y integer(0-7) for destination
  # pos_x, pos_y are current locations of piece (self)
  # determine if move is horizontal or vertical
  # then determine left/right or up/down
  # check if there is an obstruction at x,y then iterate
  # back to pos_x, pos_y.  If a single obstruction is
  # found, immediately return true.  By default, lack
  # of any obstruction will return false.

  def obstructed_move?(x, y)
    pos_x = x_position
    pos_y = y_position

    if x == pos_x # move is in y direction
      if y < pos_y # move is down
        while y < pos_y 
          return true if game.obstruction?(x, y)  
          y += 1
        end
      else # move is up
        while y > pos_y
          return true if game.obstruction?(x,y)
          y -= 1
        end
      end
    else # move is in x direction
      if x < pos_x # move is left
        while x < pos_x
          return true if game.obstruction?(x,y)
          x += 1
        end
      else # move is right
        while x > pos_x
          return true if game.obstruction?(x,y)
          x -= 1
        end
      end
    end
    return false 
  end
end