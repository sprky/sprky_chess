require 'test_helper'

class GameTest < ActiveSupport::TestCase
	test "game id matches game_id for new pieces" do
    game = FactoryGirl.create(:game, :id => 1)
    piece = game.pieces.last
    assert_equal(piece.game_id, game.id) 
  end

  test "pieces are initialized when a game is started" do
    g=Game.create
    assert_equal 32, g.pieces.count, "the incorrect number of pieces have been created"
  end
end
