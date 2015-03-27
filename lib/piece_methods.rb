class ObstructionHelper
  def initialize(piece, x, y)
    @piece = piece
    @x = x
    @y = y
  end

  def obstructed_diagonally?(x, y)
    pos_x = @piece.x_position
    pos_y = @piece.y_position
    game = @piece.game

    # (this takes you up and right)
    if pos_x < x && pos_y < y
      pos_x += 1
      pos_y += 1
      while x > pos_x && y > pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x += 1
        pos_y += 1
      end
    # (this takes you down and right)
    elsif pos_x < x && pos_y > y
      pos_x += 1
      pos_y -= 1
      while x > pos_x && y < pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x += 1
        pos_y -= 1
      end
    # (this takes you down and left)
    elsif pos_x > x && pos_y > y
      pos_x -= 1
      pos_y -= 1
      while x < pos_x && y < pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x -= 1
        pos_y -= 1
      end
    # (this takes you up and left)
    elsif pos_x > x && pos_y < y
      pos_x -= 1
      pos_y += 1
      while x < pos_x && y > pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x -= 1
        pos_y += 1
      end
    end
    false
  end
end
