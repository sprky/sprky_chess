require 'test_helper'

class GameTest < ActiveSupport::TestCase
  game = FactoryGirl.create(:game)
  assert_equal: game.id, Piece.game_id
end
