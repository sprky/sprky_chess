class Piece < ActiveRecord::Base
  belongs_to :player
  belongs_to :game

  # This is a placeholder for the move logic associated with each piece
  def is_valid_move?
  end

  def capture(destination_x_position, destination_y_position)
  	#check if a piece exists at this coordinate
    ##capture=@game.pieces.find(destination_x_position, destination_y_position)
    #if nil do nothing
    # if piece, destroy
    ## if capture=nil
    ##  return
    ## else
    ##  piece.find(destination_x_position, destination_y_position).captured? = true
    #do we want to remove from database or just from view?
    #if just from view, in view we need to say if .captured? = true then don't show 
    ## end
  	#if so destroy piece(remove from board and set as captured (if nec))
    #if nothing there do nothing
  end

end
