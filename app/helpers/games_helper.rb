module GamesHelper
  def gameboard_td(query_result, column, row)
    @gameboard_td = "<td class='x-position-#{column}'' data-x-position='#{column}'"
    @gameboard_td += " data-y-position='#{row}' data-piece-id='#{piece_id(query_result)}' data-piece-type='#{piece_type(query_result)}'>"
    unless query_result.nil?
      @gameboard_td += image_tag query_result.symbol
    end
    @gameboard_td += '</td>'
  end

  def game_message(game)
    return 'CHECKMATE!' if game.state == 'checkmate'
    return 'Waiting for opponent' if game.nil_player?
    turn = game.present? && game.turn == game.white_player_id ? 'White turn' : 'Black turn'
    "#{turn} #{game.state}".strip
  end

  def piece_image(game, player, piece_type)
    color = game.white_player_id == player.id ? 'white' : 'black'
    image_tag "#{color}-#{piece_type.downcase}.svg"
  end

  def row_range
    current_player.id == game.white_player_id ? 7.downto(0).to_a : (0..7).to_a
  end

  def show_opponent
    if current_player.id == game.white_player_id && game.black_player_id.present?
      "Black Player: #{player_email_from_id(game.black_player_id)}"
    elsif current_player.id == game.white_player_id
      "#{link_to 'Invite Player', new_game_invitations_path(game), class: 'button'}"
    else
      "White Player: #{player_email_from_id(game.white_player_id)}"
    end
  end

  def show_player
    if current_player.id == game.white_player_id
      "White Player: #{player_email_from_id(current_player)}"
    else
      "Black Player: #{player_email_from_id(current_player)}"
    end
  end
end
