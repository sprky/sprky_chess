class DashboardsController < ApplicationController
  before_action :authenticate_player!
  def show
    # get @my_games from my_games method in application_controller
    @my_games = my_games
    # get @open_games from open_games method
    @open_games = open_games
  end

  def my_games
    if player_signed_in?
      @my_games = Game.where('white_player_id = ? or black_player_id = ?', current_player.id, current_player.id).order('updated_at').to_a.first(10)
    end
  end

  def open_games
    if player_signed_in?
      @open_games = Game.where(black_player_id: nil).where(white_player_id: current_player.id).first(10)
    end
  end
end
