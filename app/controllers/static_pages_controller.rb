class StaticPagesController < ApplicationController
	
  def index
    if player_signed_in?
      @my_games = Game.where("white_player_id = ? or black_player_id = ?", current_player.id, current_player.id).order( 'updated_at').to_a
    end
  end

end
