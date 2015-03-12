class Piece < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  # This is a placeholder for the move logic associated with each piece
  def is_valid_move?
  end

  # Treating every piece as a rook
  def is_move_obstructed?(destination_x, destination_y)
  	(2..5).each do |row|
  		if !self.game.pieces.where(x_position: 0, y_position: 4).first.nil?
  			puts row
  			return true
  		end
  	end
  	return false
  end

end
