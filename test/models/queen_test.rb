require 'test_helper'

# Tests specific to Queen logic
class QueenTest < ActiveSupport::TestCase
  test 'queen legal moves' do
    game = FactoryGirl.create(:game)
    queen = FactoryGirl.create(
      :queen,
      x_position: 4,
      y_position: 4,
      game_id: game.id)

    assert queen.legal_move?(6, 6)
    assert queen.legal_move?(4, 0)
    assert queen.legal_move?(3, 4)
  end

  test 'queen illegal moves' do
    game = FactoryGirl.create(:game)
    queen = FactoryGirl.create(
      :queen,
      x_position: 4,
      y_position: 4,
      game_id: game.id)

    assert_not queen.legal_move?(5, 6)
  end

  test 'queen move obstructed' do
    setup_obstruction_tests
    @game.pieces.create(
      type: 'Pawn',
      x_position: 6,
      y_position: 4,
      color: true)
    @game.pieces.create(
      type: 'Pawn',
      x_position: 2,
      y_position: 4,
      color: true)

    assert @queen.obstructed_move?(7, 7), 'quad 1'
    assert @queen.obstructed_move?(0, 0), 'quad 3'
    assert @queen.obstructed_move?(1, 7), 'quad 4'
    assert @queen.obstructed_move?(4, 7), 'up'
    assert @queen.obstructed_move?(4, 0), 'down'
    assert @queen.obstructed_move?(7, 4), 'right'
    assert @queen.obstructed_move?(1, 4), 'left'
  end

  test 'queen is not obstructed' do
    setup_obstruction_tests
    assert_equal false, @queen.obstructed_move?(5, 5), 'quad 1'
    assert_equal false, @queen.obstructed_move?(5, 3), 'quad 2'
    assert_equal false, @queen.obstructed_move?(3, 3), 'quad 3'
    assert_equal false, @queen.obstructed_move?(3, 5), 'quad 4'
    assert_equal false, @queen.obstructed_move?(4, 5), 'up'
    assert_equal false, @queen.obstructed_move?(4, 2), 'down'
    assert_equal false, @queen.obstructed_move?(7, 4), 'right'
    assert_equal false, @queen.obstructed_move?(0, 4), 'left'
  end

  def setup_obstruction_tests
    @game = FactoryGirl.create(:game)
    @queen = @game.pieces.where(
      type: 'Queen',
      color: true,
      game_id: @game.id).last
    @queen.update_attributes(x_position: 4, y_position: 4)
    @game.reload
  end
end
