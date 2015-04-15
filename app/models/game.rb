class Game < ActiveRecord::Base
  after_create :initialize_board!

  has_many :players
  has_many :pieces
  has_many :invitations

  after_rollback :throw_invalid_move

  def assign_pieces
    pieces.where(color: true).each do |p|
      p.update_attributes(player_id: white_player_id)
    end

    pieces.where(color: false).each do |p|
      p.update_attributes(player_id: black_player_id)
    end
  end

  # determines if color is in check
  def check?(color)
    # make sure it's other player's turn
    switch_players(!color)
    # puts "Checking #{color}. Turn is #{turn}"

    king = pieces.find_by(type: 'King', color: color)
    opponents = pieces_remaining(!color)

    opponents.each do |piece|
      return true if piece.valid_move?(
        king.x_position,
        king.y_position)
    end
    false
  end

  # determine if a state of checkmate has occurred
  def checkmate?(color)
    checked_king = pieces.find_by(type: 'King', color: color)

    # see if king can get himself out of check
    return false if checked_king.can_move_out_of_check?

    # # see if another piece can block check
    # return false if piece_can_block_check

    # # see if another piece can capture checking piece
    # return false if checking_piece_can_be_captured

    true
  end

  def initialize_board!
    # White Pieces
    (0..7).each do |i|
      Pawn.create(
        game_id: id,
        x_position: i,
        y_position: 1,
        color: true
        )
    end

    Rook.create(game_id: id, x_position: 0, y_position: 0, color: true)
    Rook.create(game_id: id, x_position: 7, y_position: 0, color: true)

    Knight.create(game_id: id, x_position: 1, y_position: 0, color: true)
    Knight.create(game_id: id, x_position: 6, y_position: 0, color: true)

    Bishop.create(game_id: id, x_position: 2, y_position: 0, color: true)
    Bishop.create(game_id: id, x_position: 5, y_position: 0, color: true)

    Queen.create(game_id: id, x_position: 3, y_position: 0, color: true)
    King.create(game_id: id, x_position: 4, y_position: 0, color: true)

    # Black Pieces
    (0..7).each do |i|
      Pawn.create(
        game_id: id,
        x_position: i,
        y_position: 6,
        color: false
        )
    end

    Rook.create(game_id: id, x_position: 0, y_position: 7, color: false)
    Rook.create(game_id: id, x_position: 7, y_position: 7, color: false)

    Knight.create(game_id: id, x_position: 1, y_position: 7, color: false)
    Knight.create(game_id: id, x_position: 6, y_position: 7, color: false)

    Bishop.create(game_id: id, x_position: 2, y_position: 7, color: false)
    Bishop.create(game_id: id, x_position: 5, y_position: 7, color: false)

    Queen.create(game_id: id, x_position: 3, y_position: 7, color: false)
    King.create(game_id: id, x_position: 4, y_position: 7, color: false)
  end

  # determind if obstruction occurs at x, y in game
  def obstruction(x, y)
    pieces.where(x_position: x, y_position: y).last
  end

  def pieces_remaining(color)
    pieces.includes(:game).where(
      "color = ? and state != 'captured'",
      color).to_a
  end

  # switches game turn to color
  def switch_players(color)
    # ensure that game is set to correct turn
    if color
      update_attributes(turn: white_player_id)
    else
      update_attributes(turn: black_player_id)
    end
  end

  # update turn and game state after successful move
  def update_state(current_player_color)
    # check if opposite player is in check
    if check?(!current_player_color)
      puts "We're in check. Look for checkmate"
      if checkmate?(!current_player_color)
        puts
        puts '*!&^' * 20
        puts
        puts 'Checkmate'
      else
        # if so, game state is check
        update_attributes(state: 'check')
      end
    else
      # if not, game state is not check
      update_attributes(state: nil)
    end
    # give turn over to other player
    switch_players(!current_player_color)
  end

  private

  def throw_invalid_move
    update_attributes(state: "Invalid Move - you can't move into check")
  end
end
