require 'test_helper'

class GameTest < ActiveSupport::TestCase
	test "game id matches game_id for new pieces" do
    game = FactoryGirl.create(:game, :id => 1)
    piece = game.pieces.last
    assert_equal(piece.game_id, game.id) 
  end
end
