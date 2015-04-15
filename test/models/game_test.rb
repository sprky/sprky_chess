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
    game = FactoryGirl.create(
      :game,
      black_player_id: 1,
      white_player_id: 2)
    game.assign_pieces

    assert_equal 16, game.pieces.where(player_id: 1).count
    assert_equal 16, game.pieces.where(player_id: 2).count
  end

  test 'pieces remaining' do
    game = FactoryGirl.create(
      :game,
      black_player_id: 1,
      white_player_id: 2,
      turn: 1)
    game.assign_pieces

    expected = 16
    actual = game.pieces_remaining(true).length

    assert_equal expected, actual
  end

  test 'should be in check' do
    game = FactoryGirl.create(
      :game,
      black_player_id: 1,
      white_player_id: 2,
      turn: 1)
    game.assign_pieces
    FactoryGirl.create(
      :knight,
      player_id: 1,
      x_position: 5,
      y_position: 2,
      game_id: game.id,
      color: false)
    assert game.check?(true)
  end

  # test 'should be in checkmate' do
  #  game = FactoryGirl.create(
  #    :game,
  #   black_player_id: 1,
  #    white_player_id: 2,
  #   turn: 1)
  #  game.assign_pieces

  #  black_king = game.pieces.find_by(type: 'King', color: false)
  #  black_king.update_attributes(x_position: 4, y_position: 4, state: 'moved')
  #  pawn1 = game.pieces.find_by(type: 'Pawn', color: true, x_position: 4)
  #  pawn1.update_attributes(y_position: 2, state: 'moved')
  #  rook1 = game.pieces.find_by(type: 'Rook', color: true, x_position: 7)
  #  rook1.update_attributes(y_position: 3, state: 'moved')
  #  rook2 = game.pieces.find_by(type: 'Rook', color: true, x_position: 0)
  #  rook2.update_attributes(y_position: 3, state: 'moved')
  #  bishop1 = game.pieces.find_by(type: 'Bishop', color: true, x_position: 2)
  #  bishop1.update_attributes(y_position: 5, state: 'moved')
  #  bishop2 = game.pieces.find_by(type: 'Bishop', color: true, x_position: 5)
  #  bishop2.update_attributes(y_position: 5, x_position: 6, state: 'moved')
  #  black_bishop = game.pieces.find_by(type: 'Bishop', color: false, x_position: 5)
  #  black_bishop.destroy
  #  assert game.checkmate?(false)
  # end

  test 'should not be in checkmate' do
    game = FactoryGirl.create(
      :game,
      black_player_id: 1,
      white_player_id: 2,
      turn: 1)
    game.assign_pieces

    assert_not game.checkmate?(true)
  end
end
