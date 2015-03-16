require 'test_helper'

class BishopTest < ActiveSupport::TestCase
	
  test "Bishop legal moves"  do
    setup_bishop
    
    assert @bishop.legal_move?(6, 7)
    assert @bishop.legal_move?(1, 2)
    assert @bishop.legal_move?(1, 6)
    assert @bishop.legal_move?(5, 6)
  end

  test "Bishop illegal moves" do
    setup_bishop

    assert_not @bishop.legal_move?(5, 7)
    assert_not @bishop.legal_move?(3, 7)
    assert_not @bishop.legal_move?(1, 4)
  end

  test "Bishop is obstructed" do
    setup_obstruction_tests

    assert_equal true, @bishop.obstructed_move?(5, 6), "quad 1"
    #assert_equal true, @bishop.obstructed_move?(6, 1), "quad 2"
    #assert_equal true, @bishop.obstructed_move?(1, 2), "quad 3"
    #assert_equal true, @bishop.obstructed_move?(1, 6), "quad 4"
  end

  def setup_bishop
    @bishop = FactoryGirl.create(:bishop, x_position: 3, y_position: 4, color: true)
  end

  def setup_obstruction_tests
    game = FactoryGirl.create(:game)
    @bishop = game.pieces.where( type: 'Bishop').last
    @bishop.x_position = 3
    @bishop.y_position = 4
    @pawn = game.pieces.where( x_position: 0, y_position: 0).last
    @pawn2 = game.pieces.where( x_position: 7, y_position: 7).last
  end

end
