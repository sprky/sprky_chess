require 'test_helper'

class GameTest < ActiveSupport::TestCase
	
  test "obstruction method"  do
    game = FactoryGirl.create(:game)

    assert_instance_of Rook, game.obstruction(0,0), "Should return rook"
    assert_instance_of Pawn, game.obstruction(3,6), "Should return pawn"
    assert_instance_of Queen, game.obstruction(3,7), "Should return queen"
    assert_instance_of Bishop, game.obstruction(5,0), "Should return bishop"
    assert_nil game.obstruction(2,2), "Should return nil"
  end
end
