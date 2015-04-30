module GamesHelper
  def message(game)
    message = game.present? && game.turn == game.white_player_id ? 'White turn' : 'Black turn'
    "#{message} #{game.state}"
  end

  def piece_image(game, player, piece)
    color = game.white_player_id == player.id ? 'white' : 'black'
    image_tag "#{color}-#{piece}.svg"
  end
end
