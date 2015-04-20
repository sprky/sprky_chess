require 'test_helper'

# Tests for valid_move? and move_to Piece Logic
class PieceTransactionsTest < ActiveSupport::TestCase
  test 'Should revert database on king moved into check' do
    setup_game_and_pieces
    @white_king.update_attributes(x_position: 4, y_position: 3)
    @white_king.reload
    @white_king.attempt_move(@white_king, x_position: 4, y_position: 4)
    @white_king.reload

    assert_equal 3, @white_king.y_position, 'King reverts back to y position 3'
    assert_equal @white_player.id, @game.turn, "Should still be white player's turn"
  end

  test 'Should revert database on castling move' do
    setup_game_and_pieces
    @white_king.attempt_move(@white_king, x_position: 6, y_position: 0)
    @white_king.reload
    @white_kings_rook.reload

    assert_equal 4, @white_king.x_position, 'King reverts to original x position'
    assert_equal 7, @white_kings_rook.x_position, 'Rook reverts to original x position'
    refute_equal 'castled', @white_king.state, 'King is not marked castled'
    refute_equal 'moved', @white_kings_rook.state, 'Rook is not marked moved'
    assert_equal @white_player.id, @game.turn, "Should still be white player's turn"
  end

  private

  def setup_game_and_pieces
    @white_player = FactoryGirl.create(:player)
    @game = FactoryGirl.create(:game, white_player_id: @white_player.id, turn: @white_player.id)
    @white_king = @game.pieces.find_by(type: 'King', color: true)
    @black_pawn = FactoryGirl.create(
      :pawn,
      x_position: 5,
      y_position: 5,
      color: false,
      game_id: @game.id)
    @white_kings_rook = @game.pieces.find_by(type: 'Rook', color: true, x_position: 7)
  end
end
