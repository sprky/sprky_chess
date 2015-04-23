class PiecesController < ApplicationController
  def update
    @piece = Piece.find(params[:id])
    @game = @piece.game

    unless your_turn?(current_player)
      render text: 'It must be your turn',
             status: :unauthorized
      else
        @piece.attempt_move(piece_params)

        render json: {
          update_url: game_path(@game)
        }

        update_firebase(
          update_url: game_path(@game),
          time_stamp: Time.now.to_i)
    end
  end

  private

  def piece_params
    @piece_params = params.require(:piece).permit(
      :x_position,
      :y_position)
  end

  def your_turn?(current_player)
    @game.turn == current_player.id
  end

  def update_firebase(data)
    firebase = Firebase::Client.new(Rails.application.config.base_uri)

    response = firebase.set("game#{@game.id}", data)
    response.success?
  end
end
