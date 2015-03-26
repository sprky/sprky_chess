module ApplicationHelper

  def piece_id(piece)
    piece.present? ? piece.id : nil
  end
end
