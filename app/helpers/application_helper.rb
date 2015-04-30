module ApplicationHelper
  def gameboard_td(query_result, column, row)
    @gameboard_td = "<td class='x-position-#{column}'' data-x-position='#{column}'"
    @gameboard_td += " data-y-position='#{row}' data-piece-id='#{piece_id(query_result)}' data-piece-type='#{piece_type(query_result)}'>"
    unless query_result.nil?
      @gameboard_td += image_tag query_result.symbol
    end
    @gameboard_td += '</td>'
  end

  def player_email_from_id(player_id)
    player = Player.find(player_id)
    player.email
  end

  def piece_id(piece)
    piece.present? ? piece.id : nil
  end

  def piece_type(piece)
    piece.present? ? piece.type : nil
  end

  def your_turn?
    @game.turn == current_player.id
  end
end
