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

    if @game.valid? && unique_players?
      @game.update_attributes(game_params)
      @game.assign_pieces
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

  def unique_players?
    @game.white_player_id != game_params[:black_player_id].to_i
  end
end
