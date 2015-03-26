class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def my_games
    if player_signed_in?
      @my_games = Game.where('white_player_id = ? or black_player_id = ?', current_player.id, current_player.id).order('updated_at').to_a.first(10)
    end
  end

  def open_games
    if player_signed_in?
      @open_games = Game.where(black_player_id: nil).where.not(white_player_id: current_player.id).first(10)
    end
  end
end
