class Bishop < Piece
	def legal_move?(x, y)
    (x_position - x).abs == (y_position - y).abs
  end

  def obstructed_move?(x,y)
  	pos_x = x_position
  	pos_y = y_position
  	
  	#(this takes you up and right)
  	if pos_x < x && pos_y < y 
  		while x > pos_x && y > pos_y
  			return true if game.obstruction(pos_x, pos_y)
  			pos_x += 1
  			pos_y += 1
  		end
  	#(this takes you down and right)
  	elsif pos_x < x && pos_y > y
  		while x > pos_x && y < pos_y
  			return true if game.obstruction(pos_x, pos_y)
  			pos_x += 1
  			pos_y -= 1
  		end
  	#(this takes you down and left)
  	elsif pos_x > x && pos_y > y 
  		while x < pos_x && y < pos_y
  			return true if game.obstruction(pos_x, pos_y)
  			pos_x -= 1
  			pos_y -= 1
      end
  	#(this takes you up and left)
  	elsif pos_x > x && pos_y < y
  		while x < pos_x && y > pos_y
  			return true if game.obstruction(pos_x, pos_y)
  			pos_x -= 1
  			pos_y += 1
  		end
    end
    # capture logic  - I think this can get refactored into a method used by all the pieces except pawn
    destination_obstruction = game.obstruction(x, y) # is there something at the destination?
    if destination_obstruction && destination_obstruction.color == self.color
      # yes and it's the same color - it's an obstruction
      return true
    elsif destination_obstruction && destination_obstruction.color != self.color
      # yes but it's a different color - capture it
      # destination_obstruction.mark_captured
      return false # no obstruction, piece should move there.
    end
    
    return false
  end
end