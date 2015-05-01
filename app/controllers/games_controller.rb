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
  end

  def index
    redirect_to dashboard_path
  end

  def update
    if game.valid? && unique_players?
      game.update_attributes game_params
      game.assign_pieces
      return redirect_to game_path game
    end

    render :new, status: :unprocessable_entity
  end

  private

  def game
    @game ||= Game.find params[:id]
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
