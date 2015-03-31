module GamesHelper
  def player_email_from_id(player_id)
    player = Player.find(player_id)
    player.email
  end

  def message(game)
    game.present? && game.turn == game.white_player_id ? 'White turn' : 'Black turn'
  end
end
