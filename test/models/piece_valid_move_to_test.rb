require 'test_helper'

# Tests for valid_move? and move_to Piece Logic
class PieceValidMoveToTest < ActiveSupport::TestCase
  test 'should be valid move' do
    game = FactoryGirl.create(:game)
    piece = FactoryGirl.create(
      :rook,
      x_position: 5,
      y_position: 4,
      color: true,
      game_id: game.id)

    assert piece.valid_move?(7, 4)
    assert piece.valid_move?(5, 6)
  end

  test 'should be invalid moves' do
    game = FactoryGirl.create(:game)
    piece = FactoryGirl.create(
      :rook,
      x_position: 5,
      y_position: 4,
      color: true,
      game_id: game.id)

    assert_not piece.valid_move?(5, 4), 'Is nil move'
    assert_not piece.valid_move?(8, 4), 'Is not on board'
    assert_not piece.valid_move?(3, 3), 'Is illegal move'
    assert_not piece.valid_move?(5, 0), 'Is obstructed by pawn'
    assert_not piece.valid_move?(5, 1), 'Destination obstructed'
  end

  test 'should move to' do
    game = FactoryGirl.create(:game)
    piece = FactoryGirl.create(
      :rook,
      x_position: 5,
      y_position: 4,
      color: true,
      game_id: game.id)
    piece.move_to(piece, x_position: 7, y_position: 4)

    # puts piece.move_to(piece, x_position: 7, y_position: 4)

    assert_equal 7, piece.x_position
    assert_equal 4, piece.y_position
    assert_equal 'moved', piece.state
  end

  test 'king should move to' do
    game = FactoryGirl.create(:game)
    piece = FactoryGirl.create(
      :king,
      x_position: 5,
      y_position: 4,
      color: true,
      game_id: game.id)
    piece.move_to(piece, x_position: 6, y_position: 4)

    assert_equal 6, piece.x_position
    assert_equal 4, piece.y_position
    assert_equal 'moved', piece.state
  end

  test 'should move to and capture' do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(
      :pawn,
      x_position: 1,
      y_position: 3,
      color: true,
      game_id: game.id)
    black_pawn = FactoryGirl.create(
      :pawn,
      x_position: 2,
      y_position: 4,
      color: false,
      game_id: game.id)
    assert white_pawn.capture_move?(2, 4), 'capture move'
    white_pawn.move_to(white_pawn, x_position: 2, y_position: 4)
    white_pawn.reload
    assert_equal 2, white_pawn.x_position
    assert_equal 4, white_pawn.y_position
    black_pawn.reload
    assert_equal 'captured', black_pawn.state, 'captured black pawn'
  end

  test 'Should allow moved not causing check' do
    game = FactoryGirl.create(:game)
    black_pawn = FactoryGirl.create(
      :pawn,
      x_position: 2,
      y_position: 4,
      color: false,
      game_id: game.id)
    black_pawn.attempt_move(black_pawn, x_position: 2, y_position: 3)
    black_pawn.reload

    assert_equal 3, black_pawn.y_position, 'Pawn moves to y position 3'
  end

  #  test 'Should allow capture of piece causing check' do
  #   game = FactoryGirl.create(:game)
  #   black_queen = game.pieces.find_by(type: 'Queen', color: false)
  #   black_queen.update_attributes(x_position: 7, y_position: 3)
  #   game.pieces.find_by(x_position: 5, y_position: 1).destroy
  #   rook = game.pieces.find_by(type: 'Rook', color: true, x_position: 7)
  #   rook.update_attributes(x_position: 4, y_position: 3)
  #   black_queen.reload
  #   rook.reload

  #  assert black_queen.can_capture_piece_causing_check
  #  end
end
