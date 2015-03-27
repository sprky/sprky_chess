class Rook < Piece
  def legal_move?(x, y)
    x_position == x || y_position == y
  end
  
  def obstructed_move?(x, y)
    obstructed_rectilinearly?(x, y)
  end

  # used to find the correct rook or castling
  # passes a king and a side string ["King","Queen"]
  # returns the appropriate rook
  def self.rook_for_castling( king, side)
    if side == "King" 
      return king.game.pieces.find_by(type: 'Rook', x_position: 7, y_position: king.y_position)
    elsif side == "Queen"
      return king.game.pieces.find_by(type: 'Rook', x_position: 0, y_position: king.y_position)
    else
      return nil
    end
  end

end