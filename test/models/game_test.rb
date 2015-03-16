require 'test_helper'

class GameTest < ActiveSupport::TestCase
	test "piece is marked as captured" do

   
    #game created
    g=FactoryGirl.create(:game, :id => 1)
    #pawn put at 1,1 in game:1
    pawn = Piece.where(:x_position => 1, :y_position => 1, :game_id => 1).last
    #run capture method on the game
    g.capture(1, 1)
    pawn.reload
    assert_equal(true, pawn.captured?)
    assert_equal(nil, pawn.x_position)
    assert_equal(nil, pawn.y_position)
  end
end
