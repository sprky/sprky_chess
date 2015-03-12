class Piece < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  # This is a placeholder for the move logic associated with each piece
  def is_valid_move?
  end

  # Treating every piece as a rook
  def is_move_obstructed?(destination_x, destination_y)
  	(2..7).each do |row|
      piece = self.game.pieces.where(x_position: 0, y_position: row).first
      puts row
      puts piece
  		if !piece.nil?
  			return true
  		end
  	end
  	return false
  end

end
