class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    # move piece if move is valid
    @piece.move_to(@piece, piece_params)

    game = @piece.game

    render json: {
      update_url: game_path(game)
    }
  end

  private

  def piece_params
    @piece_params = params.require(:piece).permit(:x_position, :y_position)
  end
end
