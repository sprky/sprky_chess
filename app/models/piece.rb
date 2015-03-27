class Piece < ActiveRecord::Base
  MIN_BOARD_SIZE = 0
  MAX_BOARD_SIZE = 7

  after_initialize :set_default_images
  after_initialize :set_default_state

  belongs_to :player
  belongs_to :game

  def valid_move?(x, y)
    #check to make sure move isn't back to same spot
    return false if nil_move?(x, y)

    return false if !move_on_board?(x, y)

    return false if !legal_move?(x, y)

    return false if obstructed_move?(x, y)
    
    return false if destination_obstructed?(x, y)

    # check that the move doesn't put the king into check
    # return false if move_causes_check?(x, y)

    return true
  end

  def capture_move?(x, y)
    captured_piece = game.obstruction(x, y)
    captured_piece && captured_piece.color != self.color
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
    self.update_attributes( captured?: true, x_position: nil, y_position: nil, state: "captured")
  end
  
  def move_on_board?(x, y)
    (x <= MAX_BOARD_SIZE && x >= MIN_BOARD_SIZE) && (y <= MAX_BOARD_SIZE && y >= MIN_BOARD_SIZE)
  end

  def move_to(piece, params)
    x = params[:x_position].to_i
    y = params[:y_position].to_i

    if piece.valid_move?(x, y)
      if capture_move?(x, y)
        captured = game.obstruction(x,y)
        captured.mark_captured
      end
      piece.update_attributes(params)
      piece.state = "moved"
      piece.save
    end
  end
  
  def nil_move?(x, y)
    x_position == x && y_position == y
  end

  def obstructed_diagonally?(x, y)
    pos_x = x_position
    pos_y = y_position
    
    #(this takes you up and right)
    if pos_x < x && pos_y < y 
      pos_x += 1
      pos_y += 1
      while x > pos_x && y > pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x += 1
        pos_y += 1
      end
    #(this takes you down and right)
    elsif pos_x < x && pos_y > y
      pos_x += 1
      pos_y -= 1
      while x > pos_x && y < pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x += 1
        pos_y -= 1
      end
    #(this takes you down and left)
    elsif pos_x > x && pos_y > y 
      pos_x -= 1
      pos_y -= 1
      while x < pos_x && y < pos_y
        return true if game.obstruction(pos_x, pos_y)
        pos_x -= 1
        pos_y -= 1
      end
    #(this takes you up and left)
    elsif pos_x > x && pos_y < y
      pos_x -= 1
      pos_y += 1
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
    return false
  end

  private

  def set_default_images
    self.symbol ||= "#{color_name}-#{type.downcase}.gif"
  end

  def set_default_state
    self.state ||= "unmoved"
  end

end
