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
    game.update_attributes game_params

    if game.valid? && game.unique_players?
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
end
