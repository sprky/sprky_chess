require 'test_helper'

class PawnPromotionTest < ActiveSupport::TestCase
  test 'Should show white pawn can promote' do
    setup_game_and_advanced_pawn

    assert @pawn.pawn_can_promote?(7)
  end

  test 'Should move white pawn off board from promotion and replace with Queen' do
    setup_game_and_advanced_pawn

    assert @pawn.pawn_promotion(1, 7)
    assert_equal nil, @pawn.x_position, 'Pawn x position is nil'
    assert_equal nil, @pawn.y_position, 'Pawn y position is nil'
    assert_equal 'Queen', @game.pieces.find_by(x_position: 1, y_position: 7).type
  end

  test 'Should allow pawn promotion move' do
    setup_game_and_advanced_pawn

    @pawn.move_to(@pawn, x_position: 1, y_position: 7)
    @pawn.reload

    assert_equal nil, @pawn.x_position, 'Pawn x position is nil'
    assert_equal nil, @pawn.y_position, 'Pawn y position is nil'
    assert_equal 'Queen', @game.pieces.find_by(x_position: 1, y_position: 7).type
  end

  test 'Should prevent pawn promotion move' do
    setup_game_and_advanced_pawn
    # pawn is blocked by a white pawn at 2, 7
    @pawn.move_to(@pawn, x_position: 2, y_position: 7)
    @pawn.reload

    refute_equal nil, @pawn.x_position, 'Pawn x position is not nil'
    refute_equal nil, @pawn.y_position, 'Pawn y position is not nil'
    refute_equal 'Queen', @game.pieces.find_by(x_position: 2, y_position: 7).type
  end

  test 'Should prevent backward move to promote' do
    setup_game_and_advanced_pawn

    @pawn_to_move_backward.move_to(@pawn, x_position: 0, y_position: 0)
    @pawn.reload

    refute_equal nil, @pawn_to_move_backward.x_position, 'Pawn x position is not nil'
    refute_equal nil, @pawn_to_move_backward.y_position, 'Pawn y position is not nil'
    assert_nil @game.pieces.find_by(x_position: 0, y_position: 0)
  end

  private

  def setup_game_and_advanced_pawn
    @game = FactoryGirl.create(:game)
    @game.pieces.find_by(x_position: 1, y_position: 7).destroy
    @game.pieces.find_by(x_position: 2, y_position: 7).destroy
    @pawn = @game.pieces.find_by(x_position: 1, y_position: 1)
    @pawn.update_attributes(y_position: 6)
    @pawn.reload
    @pawn2 = @game.pieces.find_by(x_position: 2, y_position: 1)
    @pawn2.update_attributes(y_position: 7)
    @pawn2.reload
    @pawn_to_move_backward = @game.pieces.find_by(x_position: 0, y_position: 1)
    # destroy rook behind to attempt backward move
    @game.pieces.find_by(x_position: 0, y_position: 0).destroy
  end
end
