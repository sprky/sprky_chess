class Piece < ActiveRecord::Base
  MIN_BOARD_SIZE = 0
  MAX_BOARD_SIZE = 7

  after_initialize :set_default_images

  belongs_to :player
  belongs_to :game

  def valid_move?(x, y)
    #check to make sure move isn't back to same spot
    return false if nil_move?(x, y)

    # # check if move is on board
    # return false if !move_on_board?(x, y)

    # check that move is legal, implemented by each piece
    return false if !legal_move?(x, y)

    # # check that move is not obstructed
    # return false if obstructed_move?(x, y)
    
    # check that destination isn't blocked by piece of same color
    return false if destination_obstructed?(x, y)

    # check that the move doesn't put the king into check
    # return false if move_causes_check?(x, y)

    # otherwise return true
    return true
  end

  def color_name
    color ? "white" : "black"
  end

  def destination_obstructed?(x, y)
    destination_obstruction = game.obstruction(x, y) # is there something at the destination?
    if destination_obstruction && destination_obstruction.color == self.color
      # yes and it's the same color - it's an destination_obstruction
      return true
    end
  end

  def legal_move?(x, y)
    raise NotImplementedError "Pieces must implement #legal_move?"
  end

  def mark_captured
    self.update_attributes( captured?: true, x_position: nil, y_position: nil)
  end
  
  def move_on_board?(x, y)
    (x <= MAX_BOARD_SIZE && x >= MIN_BOARD_SIZE) && (y <= MAX_BOARD_SIZE && y >= MIN_BOARD_SIZE)
  end
  
  def nil_move?(x, y)
    x_position == x && y_position == y
  end

  def obstructed_diagonally?(x, y)
    pos_x = x_position
    pos_y = y_position
    
    #(this takes you up and right)
    if pos_x < x && pos_y < y 
      while x > pos_x && y > pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x += 1
        pos_y += 1
      end
    #(this takes you down and right)
    elsif pos_x < x && pos_y > y
      while x > pos_x && y < pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x += 1
        pos_y -= 1
      end
    #(this takes you down and left)
    elsif pos_x > x && pos_y > y 
      while x < pos_x && y < pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x -= 1
        pos_y -= 1
      end
    #(this takes you up and left)
    elsif pos_x > x && pos_y < y
      while x < pos_x && y > pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x -= 1
        pos_y += 1
      end
    end
    
    return false
  end

  def obstructed_move?(x, y)
    raise NotImplementedError "Pieces must implement #obstructed_move?"
  end

  def obstructed_rectilinearly?(x, y)
    pos_x = x_position
    pos_y = y_position

    if x == pos_x # move is in y direction
      if y < pos_y # move is down
        while y < pos_y 
          return true if game.obstruction(pos_x, pos_y)  
          pos_y -= 1
        end
      else # move is up
        while y > pos_y
          return true if game.obstruction(pos_x, pos_y)
          pos_y += 1
        end
      end
    else # move is in x direction
      if x < pos_x # move is left
        while x < pos_x
          return true if game.obstruction(pos_x, pos_y)
          pos_x -= 1
        end
      else # move is right
        while x > pos_x
          return true if game.obstruction(pos_x, pos_y)
          pos_x += 1
        end
      end
    end

    return false
  end

  private

  def set_default_images
    self.symbol ||= "#{color_name}-#{type.downcase}.gif"
  end

end
