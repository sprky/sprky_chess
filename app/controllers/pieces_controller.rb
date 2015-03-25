class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    @piece.update_attributes(piece_params)
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
