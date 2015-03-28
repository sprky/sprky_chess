module Obstructions
  def destination_obstructed?(x, y)
    destination_obstruction = game.obstruction(x, y) # is there something at the destination
    # if it's the same color as piece it's a destination_obstruction
    destination_obstruction && destination_obstruction.color == color
  end

  def obstructed_diagonally?(x, y)
    # store piece x & y positions in local variables
    pos_x = x_position
    pos_y = y_position

    # check for moves that aren't diagonal
    return false if x == pos_x
    return false if y == pos_y

    # determine horizontal and vertical increment values
    horizontal_increment = x > pos_x ? 1 : -1
    vertical_increment = y > pos_y ? 1 : -1

    # increment once to move off of starting square
    pos_x += horizontal_increment
    pos_y += vertical_increment

    # loop through all values stopping before x, y
    while (x - pos_x).abs > 0 && (y - pos_y).abs > 0
      # return true if we find an obstruction
      return true if game.obstruction(pos_x, pos_y)
      pos_x += horizontal_increment
      pos_y += vertical_increment
    end

    # default to false
    false
  end

  def obstructed_rectilinearly?(x, y)
    # store piece x & y positions in local variables
    pos_x = x_position
    pos_y = y_position

    if y == pos_y # move is in x direction
      # determine horizontal increment value
      horizontal_increment = x > pos_x ? 1 : -1

      # increment once to mvoe off of starting square
      pos_x += horizontal_increment

      # loop through all values stopping before x
      while (x - pos_x).abs > 0
        # return true if we find an obstruction
        return true if game.obstruction(pos_x, pos_y)
        pos_x += horizontal_increment
      end
    elsif x == pos_x # move is in y direction
      # determine vertical increment value
      vertical_increment = y > pos_y ? 1 : -1

      # increment once to mvoe off of starting square
      pos_y += vertical_increment

      # loop through all values stopping before x
      while (y - pos_y).abs > 0
        # return true if we find an obstruction
        return true if game.obstruction(pos_x, pos_y)
        pos_y += vertical_increment
      end
    end

    # default to false
    false
  end
end
