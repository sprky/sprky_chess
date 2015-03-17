class Queen < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y ||
      (x_position - x).abs == (y_position - y).abs
  end

  def obstructed_move?(x, y)
    pos_x = x_position
    pos_y = y_position

    if x == pos_x # move is in y direction
      if y < pos_y # move is down
        while y < pos_y do 
          if game.obstruction(x, y)
            return true
          end
          y += 1
        end
      else # move is up
        while y > pos_y do
          if game.obstruction(x,y)
            return true
          end
          y -= 1
        end
      end
    elsif y == pos_y # move is in x direction
      if x < pos_x # move is left
        while x < pos_x do
          if game.obstruction(x,y)
            return true
          end
          x += 1
        end
      else # move is right
        while x > pos_x do
          if game.obstruction(x,y)
            return true
          end
          x -= 1
        end
      end
      #(this takes you up and right)
  	elsif pos_x < x && pos_y < y 
  		while x > pos_x && y > pos_y
  			if game.obstruction(x, y) != nil
  				return true
  			end
  			x -= 1
  			y -= 1
  		end
  		#(this takes you down and right)
  	elsif pos_x < x && pos_y > y
  		while x > pos_x && y < pos_y
  			if game.obstruction(x, y) != nil
  				return true
  			end
  			x -= 1
  			y += 1
  		end
  		#(this takes you down and left)
  	elsif pos_x > x && pos_y > y 
  		while x < pos_x && y < pos_y
  			if game.obstruction(x, y) != nil
  				return true
  			end
  			x += 1
  			y += 1
      end
  		#(this takes you up and left)
  	elsif pos_x > x && pos_y < y
  		while x < pos_x && y > pos_y
  			if game.obstruction(x, y) != nil
  				return true
  			end
  			x += 1
  			y -= 1
  		end
    end
    return false 
  end
end