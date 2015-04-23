class GamesController < ApplicationController
  before_action :authenticate_player!

  def new
    @game = Game.new
  end

  def create
    @game = Game.create(game_params)
    redirect_to game_path(@game)
  end

  def show
    @game = Game.where(id: params[:id]).last
    if @game.nil?
      redirect_to dashboard_path
    else
      @pieces = @game.pieces
      end
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)

    if @game.valid? && ensure_unique_players
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(
      :name,
      :white_player_id,
      :black_player_id)
  end

  def ensure_unique_players
    if @game.white_player_id == @game.black_player_id
      @game.update_attributes(black_player_id: nil)
      return false
    else
      return true
    end
  end
end
