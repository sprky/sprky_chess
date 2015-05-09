module ApplicationHelper
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
    game.turn == current_player.id
  end
end
