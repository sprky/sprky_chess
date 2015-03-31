class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    if your_turn?
      # move piece if move is valid
      @piece.move_to(@piece, piece_params)
    end
    render json: {
      update_url: game_path(@game)
    }
  
  end

  private

  def piece_params
    @piece_params = params.require(:piece).permit(:x_position, :y_position)
  end

  def your_turn?
    @game.turn == current_player.id
  end
end
