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
    @game = Game.find(params[:id])
    @pieces = @game.pieces.to_a
    # get @my_games from my_games method in application_controller
    @my_games = my_games
    # get @open_games from open_games method
    @open_games = open_games

    if @game.nil?
      redirect_to root_path
    else
      @pieces = @game.pieces
      end
  end

  def update
    @game = Game.find(params[:id])
    @game.update_attributes(game_params)
    if @game.valid? && ensure_unique_players
      randomize_players
      @game.assign_pieces
      @game.update_attributes(turn: @game.white_player_id)
      redirect_to game_path(@game)
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def game_params
    params.require(:game).permit(:name, :white_player_id, :black_player_id)
  end

  def ensure_unique_players
    if @game.white_player_id == @game.black_player_id
      @game.update_attributes(black_player_id: nil)
      return false
    else
      return true
    end
  end

  def randomize_players
    if rand(0..1) == 1
      temp_id = @game.white_player_id
      @game.update_attributes(white_player_id: @game.black_player_id)
      @game.update_attributes(black_player_id: temp_id)
    end
  end
end
