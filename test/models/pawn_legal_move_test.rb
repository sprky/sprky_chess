require 'test_helper'

# Tests specific to legal_move? Pawn logic
class PawnLegalMoveTest < ActiveSupport::TestCase
  test 'illegal white moves' do
    setup_game_and_white_pawn

    assert_not @white_pawn.legal_move?(1, 0)
    assert_not @white_pawn.legal_move?(0, 1)
    assert_not @white_pawn.legal_move?(1, 4)
    assert_not @white_pawn.legal_move?(2, 2)
  end

  test 'legal white first moves' do
    setup_game_and_white_pawn

    assert @white_pawn.legal_move?(1, 2)
    assert @white_pawn.legal_move?(1, 3)
  end

  test 'legal white regular moves' do
    setup_game_and_white_pawn
    @white_pawn.update_piece(2, 3, 'moved')
    @white_pawn.reload

    assert @white_pawn.legal_move?(2, 4)
  end

  test 'illegal black moves' do
    setup_game_and_white_pawn
    setup_black_pawn

    assert_not @black_pawn.legal_move?(1, 7)
    assert_not @black_pawn.legal_move?(0, 6)
    assert_not @black_pawn.legal_move?(2, 5)
    assert_not @black_pawn.legal_move?(1, 3)
  end

  test 'legal black first moves' do
    setup_game_and_white_pawn
    setup_black_pawn

    assert @black_pawn.legal_move?(1, 5)
    assert @black_pawn.legal_move?(1, 4)
  end

  test 'destination obstructed' do
    setup_game_and_white_pawn
    setup_black_pawn
    @black_pawn.update_piece(1, 6, 'moved')

    FactoryGirl.create(
      :pawn,
      x_position: 1,
      y_position: 2,
      color: false,
      game_id: @game.id)

    FactoryGirl.create(
      :pawn,
      x_position: 1,
      y_position: 5,
      color: false,
      game_id: @game.id)

    assert_not @white_pawn.legal_move?(1, 2), 'destination obstructed'
    assert_not @black_pawn.legal_move?(1, 5), 'destination obstructed'
  end

  def setup_game_and_white_pawn
    @game = FactoryGirl.create(:game)
    @white_pawn = @game.pieces.find_by(
      x_position: 1,
      y_position: 1)
  end

  def setup_black_pawn
    @black_pawn = @game.pieces.find_by(
      x_position: 1,
      y_position: 6)
  end
end
