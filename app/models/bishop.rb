class Bishop < Piece
	def legal_move?(x, y)
    (x_position - x).abs == (y_position - y).abs
  end

  def obstructed_move?(x,y)
  	pos_x = self.x_position
  	pos_y = self.y_position
  	game = self.game

  	#(this takes you up and right)
  	if pos_x < x && pos_y < y 
  		while x > pos_x && y > pos_y
  			if game.obstruction?(x, y) != nil
  				return true
  			end
  			x -= 1
  			y -= 1
  		end
  		#(this takes you down and right)
  	elsif pos_x < x && pos_y > y
  		while x > pos_x && y < pos_y
  			if game.obstruction?(x, y) != nil
  				return true
  			end
  			x -= 1
  			y += 1
  		end
  		#(this takes you down and left)
  	elsif pos_x > x && pos_y > y 
  		while x < pos_x && y < pos_y
  			if game.obstruction?(x, y) != nil
  				return true
  			end
  			x += 1
  			y += 1
      end
  		#(this takes you up and left)
  	elsif pos_x > x && pos_y < y
  		while x < pos_x && y > pos_y
  			if game.obstruction?(x, y) != nil
  				return true
  			end
  			x += 1
  			y -= 1
  		end
    end
    return false
  end
end