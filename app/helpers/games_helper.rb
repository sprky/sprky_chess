module GamesHelper
  def game_message(game)
    return 'CHECKMATE!' if game.state == 'checkmate'
    turn = game.present? && game.turn == game.white_player_id ? 'White turn' : 'Black turn'
    "#{turn} #{game.state}".strip
  end

  def piece_image(game, player, piece_type)
    color = game.white_player_id == player.id ? 'white' : 'black'
    image_tag "#{color}-#{piece_type.downcase}.svg"
  end
end
