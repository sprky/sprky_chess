class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    x = piece_params[:x_position].to_i
    y = piece_params[:y_position].to_i

    puts x.class
    if @piece.valid_move?(x, y)
      puts "--------------------------valid_move"
      @piece.update_attributes(piece_params)
    
    else
      puts "---------------------------INVALID MOVE #{x}, #{y}"
    end

    
    game = @piece.game

    render :json => {
      :update_url => game_path(game)
    }


  end

  private 

  def piece_params 
    @piece_params = params.require(:piece).permit(:x_position, :y_position)
  end

end
