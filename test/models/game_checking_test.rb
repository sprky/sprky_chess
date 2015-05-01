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

  test 'knight can not be blocked to get out of check' do
    setup_game_and_king

    black_knight = @game.pieces.find_by(type: 'Knight', color: false, x_position: 1)
    black_knight.update_attributes(x_position: 5, y_position: 2)
    black_knight.reload

    assert_not black_knight.can_be_blocked?(@white_king)
    assert_not @game.checkmate?(true) # not in checkmate because white_pawns can capture knight
  end

  test 'pawn can not be blocked to get out of check' do
    setup_game_and_king

    white_pawn = @game.pieces.find_by(type: 'Pawn', color: true, x_position: 3)
    white_pawn.update_attributes(y_position: 4)
    white_pawn.reload
    black_pawn = @game.pieces.find_by(type: 'Pawn', x_position: 3, color: false)
    black_pawn.update_attributes(y_position: 1)
    black_pawn.reload

    assert_not black_pawn.can_be_blocked?(@white_king)
    assert_not @game.checkmate?(true) # not in checkmate because white_queen can capture pawn
  end

  test 'Should not be in checkmate, king can move self' do
    setup_check

    @queens_pawn = @game.pieces.find_by(x_position: 3, y_position: 1).destroy
    @game.reload

    assert @white_king.can_move_out_of_check?
    assert_not @game.checkmate?(true)
  end

  test 'Should not be in checkmate, queen can be captured' do
    setup_check

    @white_rook = @game.pieces.find_by(x_position: 0, y_position: 0)
    @white_rook.update_piece(0, 3, 'moved')
    @white_rook.reload

    assert @black_queen.can_be_captured?
    assert_not @game.checkmate?(true)
  end

  test 'Should not be in checkmate, queen can be blocked' do
    setup_check

    assert @game.check? true
    assert @black_queen.can_be_blocked?(@white_king)
    assert_not @game.checkmate?(true)
  end

  test 'Should not be in checkmate, rook can be blocked' do
    setup_check

    black_rook = @game.pieces.find_by(type: 'Rook', color: false, x_position: 0)
    black_rook.update_attributes(x_position: 4, y_position: 2)
    black_rook.reload
    @game.pieces.find_by(type: 'Pawn', color: true, x_position: 4).destroy

    assert black_rook.legal_move?(4, 0)
    assert @game.check? true
    assert black_rook.can_be_blocked?(@white_king)
    assert_not @game.checkmate?(true)
  end

  test 'Should not be in checkmate, bishop can be blocked' do
    setup_check
    black_bishop = @game.pieces.find_by(color: false, type: 'Bishop', x_position: 2)
    black_bishop.update_attributes(x_position: 1, y_position: 3)
    pawn = @game.pieces.find_by(color: true, x_position: 3)
    pawn.update_attributes(y_position: 2, state: 'moved')
    pawn.reload
    black_bishop.reload

    assert black_bishop.valid_move?(4, 0)
    assert black_bishop.capture_move?(4, 0)
    assert @game.check? true
    assert black_bishop.can_be_blocked?(@white_king)
    assert_not @game.checkmate?(true)
  end

  def setup_game_and_king
    @game = FactoryGirl.create(
      :game,
      black_player_id: 1,
      white_player_id: 2)

    @white_king = @game.pieces.find_by(type: 'King', color: true)
  end

  def setup_check
    setup_game_and_king
    @pawn1 = @game.pieces.find_by(type: 'Pawn', color: true, x_position: 5)
    @pawn1.update_attributes(y_position: 2, state: 'moved')
    @pawn1.reload
    @black_queen = @game.pieces.find_by(type: 'Queen', color: false)
    @black_queen.update_attributes(x_position: 7, y_position: 3)
    @black_queen.reload
  end
end
