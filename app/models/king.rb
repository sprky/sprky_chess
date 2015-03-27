class King < Piece
	def legal_move?(x, y)
    proper_length?(x, y) || legal_castle_move?(x, y)
  end

  def obstructed_move?(x, y)
    if x - x_position == 2
      # move is kingside castle
      return true if obstructed_rectilinearly?(7, y)
    elsif x - x_position == -2
      # move is queenside castle
      return true if obstructed_rectilinearly?(0, y)
    else
      # otherwise king moves one space - can't be obstructed
      return false
    end
  end

  def castle_move(x, y)
    # return false unless status = "unmoved"
    if x > x_position
      # kingside castle
      rook = rook_for_castling("King")
      king_x = 6
      rook_x = 5
    else
      # queenside castle
      rook = rook_for_castling("Queen")
      king_x = 2
      rook_x = 3
    end
    # return false unless rook.status = "unmoved"
    update_attributes(x_position: king_x) # mark status "castled"
    rook.update_attributes(x_position: rook_x)
  end

  def legal_castle_move?(x, y)
    x_diff = (x - x_position).abs
    y_diff = (y - y_position).abs

    return false unless x_diff == 2 && y_diff == 0
  end

  def rook_for_castling(side)
    if side == "King" 
      return game.pieces.find_by(type: 'Rook', x_position: 7, y_position: y_position)
    elsif side == "Queen"
      return game.pieces.find_by(type: 'Rook', x_position: 0, y_position: y_position)
    else
      return nil
    end
  end

end

private

def proper_length?(x, y)
  x_diff = (x - x_position).abs
  y_diff = (y - y_position).abs

  (x_diff <= 1) && (y_diff <= 1)
end