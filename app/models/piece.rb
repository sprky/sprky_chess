class Piece < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  # This is a placeholder for the move logic associated with each piece
  def is_valid_move?
  end
  
end
