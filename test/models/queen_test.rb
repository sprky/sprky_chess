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

    @game.pieces.create( type: 'Pawn', x_position: 6, y_position: 4, color: true )
    @game.pieces.create( type: 'Pawn', x_position: 2, y_position: 4, color: true )

    assert @queen.obstructed_move?(4,7), "queen is blocked up"
    assert @queen.obstructed_move?(4,1), "queen is blocked down"
    assert @queen.obstructed_move?(7,4), "queen is blocked to right"
    assert @queen.obstructed_move?(1,4), "queen is blocked to left"
    assert @queen.obstructed_move?(7, 7), "quad 1"
    assert @queen.obstructed_move?(7, 1), "quad 2"
    assert @queen.obstructed_move?(1, 1), "quad 3"
    assert @queen.obstructed_move?(1, 7), "quad 4"
  end

  test "queen is not obstructed" do
    setup_obstruction_tests
    assert_equal false, @queen.obstructed_move?(5,5), "quad 1"
    assert_equal false, @queen.obstructed_move?(5,3), "quad 2"
    assert_equal false, @queen.obstructed_move?(3,3), "quad 3"
    assert_equal false, @queen.obstructed_move?(3,5), "quad 4"
    assert_equal false, @queen.obstructed_move?(4,5), "queen can move up"
    assert_equal false, @queen.obstructed_move?(4,2), "queen can move down"
    assert_equal false, @queen.obstructed_move?(7,4), "queen can move right"
    assert_equal false, @queen.obstructed_move?(0,4), "queen can move left"
  end

  def setup_obstruction_tests
    @game = FactoryGirl.create(:game)
    @queen = @game.pieces.where( type: 'Queen', color: true).last
    @queen.x_position = 4
    @queen.y_position = 4
  end
end
