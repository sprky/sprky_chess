require 'test_helper'

# Tests specific to Rook logic
class RookTest < ActiveSupport::TestCase
  test 'illegal move' do
    rook = FactoryGirl.create(:rook, x_position: 0, y_position: 0)

    assert_equal false, rook.legal_move?(3, 3)
  end

  test 'legal move' do
    rook = FactoryGirl.create(:rook, x_position: 0, y_position: 0)

    assert_equal true, rook.legal_move?(1, 0)
  end

  test 'unobstructed moves' do
    setup_obstruction_tests
    assert_not @rook.obstructed_move?(4, 5), 'Rook can move up'
    assert_not @rook.obstructed_move?(4, 2), 'Rook can move down'
    assert_not @rook.obstructed_move?(7, 4), 'Rook can move right'
    assert_not @rook.obstructed_move?(0, 4), 'Rook can move left'
  end

  test 'obstructed moves' do
    setup_obstruction_tests
    assert @rook.obstructed_move?(4, 7), 'Rook is blocked up'
    assert @rook.obstructed_move?(4, 0), 'Rook is blocked down'
    assert @rook2.obstructed_move?(4, 0), 'Rook is blocked to right'
    assert @rook3.obstructed_move?(4, 7), 'Rook is blocked to left'
  end

  test 'Should return array of obstructed squares' do
    setup_obstruction_tests

    expected = [[4, 5], [4, 6]]
    assert_equal expected, @rook.obstructed_squares(4, 7)

    expected = [[4, 3], [4, 2], [4, 1]]
    assert_equal expected, @rook.obstructed_squares(4, 0)

    expected = [[1, 0], [2, 0], [3, 0]]
    assert_equal expected, @rook2.obstructed_squares(4, 0)

    expected = [[6, 7], [5, 7]]
    assert_equal expected, @rook3.obstructed_squares(4, 7)
  end

  # sets up a game and chooses a rook, then moves it to the center
  # of the board so it has unobstructed moves
  # selects 2 more rooks with obstructed x direction moves
  def setup_obstruction_tests
    game = FactoryGirl.create(:game)
    @rook = game.pieces.find_by(x_position: 0, y_position: 7)
    @rook.update_piece(4, 4, 'moved')
    @rook2 = game.pieces.find_by(x_position: 0, y_position: 0)
    @rook3 = game.pieces.find_by(x_position: 7, y_position: 7)
  end
end
