require 'test_helper'

class QueenTest < ActiveSupport::TestCase
  
  test "queen valid moves" do
    queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)

    assert queen.valid_move?(6, 6)
    assert queen.valid_move?(4, 0)
    assert queen.valid_move?(3, 4)
  end

  test "queen invalid moves" do
    queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)

    assert_not queen.valid_move?(5, 6)
  end

  test "queen move obstructed" do 
    setup_obstruction_tests
    assert @queen.obstructed_move?(4,6), "queen is blocked up"
    assert @queen.obstructed_move?(4,1), "queen is blocked down"
    assert @queen.obstructed_move?(4,0), "queen is blocked to right"
    assert @queen.obstructed_move?(4,7), "queen is blocked to left"
    assert @queen.obstructed_move?(6, 7), "quad 1"
    assert @queen.obstructed_move?(6, 1), "quad 2"
    assert @queen.obstructed_move?(0, 1), "quad 3"
    assert @queen.obstructed_move?(0, 7), "quad 4"
  end

  test "queen is not obstructed" do
    setup_obstruction_tests
    assert_equal false, @queen.obstructed_move?(4,5), "quad 1"
    assert_equal false, @queen.obstructed_move?(4,3), "quad 2"
    assert_equal false, @queen.obstructed_move?(2,3), "quad 3"
    assert_equal false, @queen.obstructed_move?(2,5), "quad 4"
    assert_equal false, @queen.obstructed_move?(4,5), "queen can move up"
    assert_equal false, @queen.obstructed_move?(4,2), "queen can move down"
    assert_equal false, @queen.obstructed_move?(7,4), "queen can move right"
    assert_equal false, @queen.obstructed_move?(0,4), "queen can move left"
  end

  def setup_obstruction_tests
    game = FactoryGirl.create(:game)
    @queen = game.pieces.where( type: 'Queen').last
    @queen.x_position = 4
    @queen.y_position = 4
    @rook = game.pieces.where( x_position: 0, y_position: 0).last
    @rook = game.pieces.where( x_position: 7, y_position: 7).last
    @pawn = game.pieces.where( x_position: 5, y_position: 6).last
    @pawn2 = game.pieces.where( x_position: 5, y_position: 2).last
    @pawn3 = game.pieces.where( x_position: 1, y_position: 2).last
    @pawn4 = game.pieces.where( x_position: 1, y_position: 6).last
  end
end
