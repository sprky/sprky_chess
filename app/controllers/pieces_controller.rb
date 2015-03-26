class PiecesController < ApplicationController

  def update
    @piece = Piece.find(params[:id])
    x = piece_params[:x_position].to_i
    y = piece_params[:y_position].to_i

    if @piece.valid_move?(x, y)
      @piece.update_attributes(piece_params)
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
