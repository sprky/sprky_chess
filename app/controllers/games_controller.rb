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

    if @game.valid? && @game.unique_players?
      @game.assign_pieces
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def promotion
    @game = Game.find(params[:game_id])
    @piece = @game.pieces.find_by(state: 'awaiting-pawn-promotion')
  end

  private

  def game_params
    params.require(:game).permit(
      :name,
      :white_player_id,
      :black_player_id)
  end
end
