class Piece < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  # This is a placeholder for the move logic associated with each piece
  def is_valid_move?
  end

end
#these can also be used to assign the name and symbol for each type of piece
class Pawn < Piece

end

class Rook < Piece

end

class Knight < Piece

end

class Bishop < Piece

end

class Queen < Piece

end

class King < Piece

end
