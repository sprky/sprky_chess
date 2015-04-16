require 'test_helper'

# Tests specific to Game logic
class GameCheckingTest < ActiveSupport::TestCase
  test 'Should be in check' do
    setup_check

    assert @game.check?(true)
  end

  test 'Should be in checkmate' do
    setup_check

    pawn2 = @game.pieces.find_by(type: 'Pawn', color: true, x_position: 6)
    pawn2.update_attributes(y_position: 3, state: 'moved')
    pawn2.reload

    assert @game.checkmate?(true)
  end

  test 'Should not be in checkmate, king can move self' do
    setup_check

    @queens_pawn = @game.pieces.find_by(x_position: 3, y_position: 1).destroy
    @game.reload

    assert @game.check? true
    assert @white_king.can_move_out_of_check?
    assert_not @game.checkmate?(true)
  end

  test 'Should not be in checkmate, queen can be captured' do
    setup_check

    @white_rook = @game.pieces.find_by(x_position: 0, y_position: 0)
    @white_rook.update_piece(0, 3, 'moved')
    @white_rook.reload

    assert @game.check? true
    assert @black_queen.can_be_captured?
    assert_not @game.checkmate?(true)
  end

  test 'Should not be in checkmate, queen can be blocked' do
    setup_check
    pawn = Piece.find_by(color: true, x_position: 6)

    assert @game.check? true
    assert pawn.valid_move?(6, 2)
    assert_equal 'Queen', @black_queen.type
    assert @black_queen.can_be_blocked?(@white_king)
    assert_not @game.checkmate?(true)
  end

  def setup_check
    @game = FactoryGirl.create(
      :game,
      black_player_id: 1,
      white_player_id: 2,
      turn: 1)
    @game.assign_pieces

    @white_king = @game.pieces.find_by(type: 'King', color: true)
    @pawn1 = @game.pieces.find_by(type: 'Pawn', color: true, x_position: 5)
    @pawn1.update_attributes(y_position: 2, state: 'moved')
    @pawn1.reload
    @black_queen = @game.pieces.find_by(type: 'Queen', color: false)
    @black_queen.update_attributes(x_position: 7, y_position: 3)
    @black_queen.reload
  end
end
