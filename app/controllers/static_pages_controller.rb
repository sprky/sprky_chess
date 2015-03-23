class StaticPagesController < ApplicationController
	
  def index
    # get @my_games from my_games method in application_controller
    @my_games = my_games
    # get @open_games from open_games method
    @open_games = open_games
  end

end
