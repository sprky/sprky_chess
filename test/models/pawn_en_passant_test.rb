require 'test_helper'

# Tests specific to legal_move? Pawn logic
class PawnLegalMoveTest < ActiveSupport::TestCase
  test 'Should update piece state to en passant for one turn' do
    setup_game_and_pawns

    @white_pawn.move_to(@white_pawn, x_position: 1, y_position: 3)
    @white_pawn.reload

    assert_equal 'en_passant', @white_pawn.state, 'Pawn is en passant'

    @white_pawn.move_to(@white_pawn, x_position: 1, y_position: 4)
    @white_pawn.reload

    refute_equal 'en_passant', @white_pawn.state, 'Pawn is not en passant'
  end

  test 'Should allow en passant capture only when state is correct' do
    setup_game_and_pawns

    @black_pawn.move_to(@black_pawn, x_position: 1, y_position: 4)
    @black_pawn.reload
    @white_pawn.update_piece(2, 4, 'moved')
    @white_pawn.reload

    assert @white_pawn.capture_move?(1, 4)
    refute @black_pawn.capture_move?(2, 4)
  end

  test 'Should allow capture while en passant for diagonal move' do
    setup_game_and_pawns

    @black_pawn.move_to(@black_pawn, x_position: 1, y_position: 4)
    @black_pawn.reload
    @white_pawn.update_piece(2, 3, 'moved')
    @white_pawn.reload

    assert @white_pawn.capture_move?(1, 4)
  end

  def setup_game_and_pawns
    @game = FactoryGirl.create(:game)
    @white_pawn = @game.pieces.find_by(
      x_position: 1,
      y_position: 1)
    @black_pawn = @game.pieces.find_by(
      x_position: 1,
      y_position: 6)
  end
end
