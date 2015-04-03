class Game < ActiveRecord::Base
  after_create :initialize_board!

  has_many :players
  has_many :pieces

  def assign_pieces
    pieces.where(color: true).each { |p| p.update_attributes(player_id: white_player_id) }
    pieces.where(color: false).each { |p| p.update_attributes(player_id: black_player_id) }
  end

  def check?(color)
    # puts '-' * 96
    # puts "looking to see if #{color} king is in check"
    king = pieces.find_by(type: 'King', color: color)
    king_x = king.x_position
    king_y = king.y_position
    opposing_pieces = pieces.where("color = ? and state != 'captured'", !color).to_a
    opposing_pieces.each do |piece|
      return true if piece.valid_move?(king_x, king_y)
    end
    false
  end

  def initialize_board!
    # white pawns
    (0..7).each do |i|
      Pawn.create(
        game_id: id,
        x_position: i,
        y_position: 1,
        color: true
        )
    end

    # white rooks
    Rook.create(game_id: id, x_position: 0, y_position: 0, color: true)
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: true)

    # white knights
    Knight.create(game_id: id, x_position: 1, y_position: 0, color: true)
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: true)

    # white bishops
    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: true)
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: true)

    # white queen and king
    Queen.create(game_id: id, x_position: 3, y_position: 0, color: true)
    King.create(game_id: id, x_position: 4, y_position: 0, color: true)

    # black pawns
    (0..7).each do |i|
      Pawn.create(
        game_id: id,
        x_position: i,
        y_position: 6,
        color: false
        )
    end

    # black rooks
    Rook.create(game_id: id, x_position: 0, y_position: 7, color: false)
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: false)
    # black knights
    Knight.create(game_id: id, x_position: 1, y_position: 7, color: false)
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: false)
    # black bishops
    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: false)
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: false)
    # black queen and king
    Queen.create(game_id: id, x_position: 3, y_position: 7, color: false)
    King.create(game_id: id, x_position: 4, y_position: 7, color: false)
  end

  # determind if obstruction occurs at x, y in game
  def obstruction(x, y)
    pieces.where(x_position: x, y_position: y).last
  end
end
