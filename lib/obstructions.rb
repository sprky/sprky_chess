module Obstructions
  def destination_obstructed?(x, y)
    destination_obstruction = game.obstruction(x, y) # is there something at the destination?
    if destination_obstruction && destination_obstruction.color == color
      # yes and it's the same color - it's an destination_obstruction
      return true
    end
  end

  def obstructed_diagonally?(x, y)
    pos_x = x_position
    pos_y = y_position

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

  def obstructed_rectilinearly?(x, y)
    pos_x = x_position
    pos_y = y_position

    if x == pos_x # move is in y direction
      if y < pos_y # move is down
        pos_y -= 1
        while y < pos_y
          return true if game.obstruction(pos_x, pos_y)
          pos_y -= 1
        end
      else # move is up
        pos_y += 1
        while y > pos_y
          return true if game.obstruction(pos_x, pos_y)
          pos_y += 1
        end
      end
    elsif y == pos_y # move is in x direction
      if x < pos_x # move is left
        pos_x -= 1
        while x < pos_x
          return true if game.obstruction(pos_x, pos_y)
          pos_x -= 1
        end
      else # move is right
        pos_x += 1
        while x > pos_x
          return true if game.obstruction(pos_x, pos_y)
          pos_x += 1
        end
      end
    end
    false
  end
end
