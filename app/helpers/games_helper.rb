module GamesHelper
  def message(game)
    message = game.present? && game.turn == game.white_player_id ? 'White turn' : 'Black turn'
    "#{message} #{game.state}"
  end
end
