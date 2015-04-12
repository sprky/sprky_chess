class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game
    if your_turn?
      # move piece if move is valid
      @piece.attempt_move(@piece, piece_params)
    end
    render json: {
      update_url: game_path(@game)
    }
    update_firebase(update_url: game_path(@game), time_stamp: Time.now.to_i)
  end

  private

  def piece_params
    @piece_params = params.require(:piece).permit(:x_position, :y_position)
  end

  def your_turn?
    @game.turn == current_player.id
  end

  def update_firebase(data)
    firebase = Firebase::Client.new(Rails.application.config.base_uri)

    response = firebase.set("game#{@game.id}", data)
    response.success?
  end
end
