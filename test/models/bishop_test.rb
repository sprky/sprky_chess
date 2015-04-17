require 'test_helper'

# Tests specific to Bishop logic
class BishopTest < ActiveSupport::TestCase
  test 'should be legal'  do
    setup_game

    assert @bishop.legal_move?(6, 7)
    assert @bishop.legal_move?(1, 2)
    assert @bishop.legal_move?(1, 6)
    assert @bishop.legal_move?(5, 6)
  end

  test 'should be illegal' do
    setup_game

    assert_not @bishop.legal_move?(5, 7)
    assert_not @bishop.legal_move?(3, 7)
    assert_not @bishop.legal_move?(1, 4)
  end

  test 'should not be obstructed' do
    setup_game

    assert_not @bishop.obstructed_move?(4, 5), 'quad 1'
    assert_not @bishop.obstructed_move?(4, 3), 'quad 2'
    assert_not @bishop.obstructed_move?(2, 3), 'quad 3'
    assert_not @bishop.obstructed_move?(2, 5), 'quad 4'
  end

  test 'should be obstructed' do
    setup_game
    FactoryGirl.create(
      :pawn,
      color: false,
      x_position: 4,
      y_position: 5,
      game_id: @game.id)

    assert @bishop.obstructed_move?(5, 6)
  end

  test 'Should return array of obstructed squares' do
    setup_game

    expected = [[4, 5], [5, 6]]
    assert_equal expected, @bishop.obstructed_squares(6, 7)

    expected = [[2, 3], [1, 2]]
    assert_equal expected, @bishop.obstructed_squares(0, 1)

    expected = [[2, 5], [1, 6]]
    assert_equal expected, @bishop.obstructed_squares(0, 7)

    expected = [[4, 3], [5, 2]]
    assert_equal expected, @bishop.obstructed_squares(6, 1)
  end

  def setup_game
    @game = FactoryGirl.create(:game)
    @bishop = FactoryGirl.create(
      :bishop,
      color: false,
      x_position: 3,
      y_position: 4,
      game_id: @game.id)
  end
end
