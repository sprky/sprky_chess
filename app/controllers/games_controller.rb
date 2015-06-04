class GamesController < ApplicationController
  before_action :authenticate_player!
  helper_method :game

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    unless game.present?
      return redirect_to dashboard_path
    end
  end

  def index
    redirect_to dashboard_path
  end

  def update
    if game.valid? && unique_players?
      game.update_attributes game_params
      game.assign_pieces

      # temporary fix to remedy games that allowed a white player move
      # before black player was assigned and gave black player a nil value
      if game.turn.nil? && game.black_player_id.present?
        game.update_attributes(turn: game.black_player_id)
      end

      return redirect_to game_path game
    end

    render :new, status: :unprocessable_entity
  end

  private

  def game
    @game ||= Game.where(id: params[:id]).last
  end

  def game_params
    params.require(:game).permit(
      :name,
      :white_player_id,
      :black_player_id)
  end

  def unique_players?
    @game.white_player_id != game_params[:black_player_id].to_i
  end
end
