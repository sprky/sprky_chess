class Piece < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  # This is a placeholder for the move logic associated with each piece
  def is_valid_move?
  end
  
  def capture(destination_x_position, destination_y_position)
    #check if a piece exists at this coordinate
    capture=@game.pieces.where(x_postion:destination_x_position, y_position:destination_y_position).last
    #if nil do nothing-- if piece, destroy or remove from view?
    if capture != nil
      capture.captured? == true
      capture.x_position == nil
      capture.y_position == nil
    #do we want to remove from database or just from view?
    #if just from view, in views,games,show.html.erb we need to say if .captured? = true then don't show 
    end
    #if destroying
    #if so destroy piece(remove from board and set as captured (if nec))
    #if not then this is done
  end
end
