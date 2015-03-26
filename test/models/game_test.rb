require 'test_helper'

class GameTest < ActiveSupport::TestCase
  test 'game id matches game_id for new pieces' do
    game = FactoryGirl.create(:game, id: 1)
    piece = game.pieces.last
    assert_equal(piece.game_id, game.id)
  end

  test 'pieces are initialized when a game is started' do
    g = Game.create
    assert_equal 32, g.pieces.count, 'the incorrect number of pieces have been created'
  end

  test 'obstruction method'  do
    game = FactoryGirl.create(:game)

    assert_instance_of Rook, game.obstruction(0, 0), 'Should return rook'
    assert_instance_of Pawn, game.obstruction(3, 6), 'Should return pawn'
    assert_instance_of Queen, game.obstruction(3, 7), 'Should return queen'
    assert_instance_of Bishop, game.obstruction(5, 0), 'Should return bishop'
    assert_nil game.obstruction(2, 2), 'Should return nil'
  end
end
