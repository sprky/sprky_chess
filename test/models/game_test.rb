require 'test_helper'

# Tests specific to Game logic
class GameTest < ActiveSupport::TestCase
  test 'game id matches game_id for new pieces' do
    game = FactoryGirl.create(:game, id: 1)
    piece = game.pieces.last
    assert_equal(piece.game_id, game.id)
  end

  test 'pieces are initialized when a game is started' do
    g = Game.create
    assert_equal 32, g.pieces.count, 'the incorrect number of pieces'
  end

  test 'Should return correct object from obstruction method'  do
    game = FactoryGirl.create(:game)

    assert_instance_of Rook, game.obstruction(0, 0), 'rook'
    assert_instance_of Pawn, game.obstruction(3, 6), 'pawn'
    assert_instance_of Queen, game.obstruction(3, 7), 'queen'
    assert_instance_of Bishop, game.obstruction(5, 0), 'bishop'
    assert_nil game.obstruction(2, 2), 'nil'
  end

  test 'Should assign player_id to pieces' do
    setup_game

    assert_equal 16, @game.pieces.where(player_id: 1).count
    assert_equal 16, @game.pieces.where(player_id: 2).count
  end

  test 'pieces remaining' do
    setup_game

    expected = 16
    actual = @game.pieces_remaining(true).length

    assert_equal expected, actual
  end

  test 'should be unique players' do
    setup_game
    assert @game.unique_players?
  end

  # test 'player who created game should be assigned white color' do
  #   setup_game
  #   @game.reload

  #   white_player = Player.find(@game.white_player_id)
  #   assert white_player.color
  # end

  def setup_game
    player_creating_game = FactoryGirl.create(:player, id: 2)
    @game = FactoryGirl.create(
      :game,
      black_player_id: 1,
      white_player_id: player_creating_game.id)
  end
end
