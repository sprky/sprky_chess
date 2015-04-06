module GamesHelper
  def player_email_from_id(player_id)
    player = Player.find(player_id)
    player.email
  end

  def message(game)
    message = game.present? && game.turn == game.white_player_id ? 'White turn' : 'Black turn'
    "#{message} #{game.state}"
  end
end
