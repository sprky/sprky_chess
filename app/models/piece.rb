class Piece < ActiveRecord::Base
  MIN_BOARD_SIZE = 0
  MAX_BOARD_SIZE = 7

  after_initialize :set_default_images

  belongs_to :player
  belongs_to :game

  def valid_move?(x, y)
    move_on_board?(x, y) && legal_move?(x, y)
  end

  def move_on_board?(x, y)
    (x <= MAX_BOARD_SIZE && x >= MIN_BOARD_SIZE) && (y <= MAX_BOARD_SIZE && y >= MIN_BOARD_SIZE)
  end

  def legal_move?(x, y)
    raise NotImplementedError "Pieces must implement #legal_move?"
  end

  def obstructed_move?(x, y)
    raise NotImplementedError "Pieces must implement #obstructed_move?"
  end

  def color_name
    color ? "white" : "black"
  end

  def mark_captured
    self.update_attributes( captured?: true, x_position: nil, y_position: nil)
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
  end

  private

  def set_default_images
    self.symbol ||= "#{color_name}-#{type.downcase}.gif"
  end

end
