require 'test_helper'

# Tests specific to legal_move? Pawn logic
class PawnLegalMoveTest < ActiveSupport::TestCase
  test 'illegal white moves' do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(
      :pawn,
      x_position: 1,
      y_position: 1,
      color: true,
      game_id: game.id)
    assert_not white_pawn.legal_move?(1, 0)
    assert_not white_pawn.legal_move?(0, 1)
    assert_not white_pawn.legal_move?(1, 4)
    assert_not white_pawn.legal_move?(2, 2)
  end

  test 'legal white first moves' do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(
      :pawn,
      x_position: 1,
      y_position: 1,
      color: true,
      game_id: game.id)
    assert white_pawn.legal_move?(1, 2)
    assert white_pawn.legal_move?(1, 3)
  end

  test 'legal white regular moves' do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(
      :pawn,
      x_position: 2,
      y_position: 3,
      color: true,
      game_id: game.id)
    assert white_pawn.legal_move?(2, 4)
  end

  test 'illegal black moves' do
    game = FactoryGirl.create(:game)
    black_pawn = FactoryGirl.create(
      :pawn,
      x_position: 1,
      y_position: 6,
      color: false,
      game_id: game.id)
    assert_not black_pawn.legal_move?(1, 7)
    assert_not black_pawn.legal_move?(0, 6)
    assert_not black_pawn.legal_move?(2, 5)
    assert_not black_pawn.legal_move?(1, 3)
  end

  test 'legal black first moves' do
    game = FactoryGirl.create(:game)
    black_pawn = FactoryGirl.create(
      :pawn,
      x_position: 1,
      y_position: 6,
      color: false,
      game_id: game.id)
    assert black_pawn.legal_move?(1, 5)
    assert black_pawn.legal_move?(1, 4)
  end
end
