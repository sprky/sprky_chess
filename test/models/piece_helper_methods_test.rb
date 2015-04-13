require 'test_helper'

# Tests for Piece logic helper methods
class PieceTest < ActiveSupport::TestCase
  test 'color name' do
    piece = FactoryGirl.create(:pawn)

    piece.color = 1

    assert_equal 'white', piece.color_name
  end

  test 'setting default images' do
    piece = FactoryGirl.create(:pawn)
    piece.color = 0

    assert_equal 'black-pawn.svg', piece.symbol
  end

  test 'move on board' do
    piece = FactoryGirl.create(:pawn)

    assert_equal true, piece.move_on_board?(3, 0)
  end

  test 'move is not on board' do
    piece = FactoryGirl.create(:pawn)

    assert_equal false, piece.move_on_board?(9, 0)
  end

  test 'should not capture' do
    setup_pieces
    @pawn.update_attributes(color: true)
    @pawn.reload

    assert_not @piece.capture_move?(5, 5), 'Is not a capture move'
  end

  test 'should capture' do
    setup_pieces

    assert @piece.capture_move?(5, 5), 'Is a capture move'
  end

  test 'should mark piece as captured' do
    setup_pieces

    @piece.update_piece(nil, nil, 'captured')
    @piece.reload

    assert_nil @piece.x_position, 'Should be x_position: nil'
    assert_nil @piece.y_position, 'Should be y_position: nil'
    assert_equal 'captured', @piece.state
  end

  test 'should not be a move' do
    piece = FactoryGirl.create(:rook, x_position: 5, y_position: 4)

    assert piece.nil_move?(5, 4)
    assert_not piece.nil_move?(5, 5)
  end

  test 'destination should be obstructed' do
    setup_pieces

    assert @piece.destination_obstructed?(5, 1), 'not obstructed '
    assert_not @piece.destination_obstructed?(5, 6), 'not obstructed'
    assert_not @piece.destination_obstructed?(5, 9), 'Not obstructed'
  end

  test 'Should check if moving own piece' do
    setup_pieces

    assert @piece.moving_own_piece?
    assert_not @pawn.moving_own_piece?
  end

  test 'should be able to escape check' do
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

    pawn = game.pieces.where(
      player_id: 2,
      x_position: 4,
      y_position: 1,
      game_id: game.id,
      color: true).first

    pawn.update_piece(nil, nil, 'captured')

    king = game.pieces.where(
      player_id: 2,
      x_position: 4,
      y_position: 0,
      game_id: game.id,
      color: true).first

    assert king.can_escape_check?
  end

  test 'should not be able to escape check' do
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

    king = game.pieces.where(
      player_id: 2,
      x_position: 4,
      y_position: 0,
      game_id: game.id,
      color: true).first

    assert_not king.can_escape_check?
  end

  def setup_pieces
    @player = FactoryGirl.create(:player)
    @game = FactoryGirl.create(:game, turn: @player.id)
    @piece = FactoryGirl.create(
      :rook,
      x_position: 5,
      y_position: 4,
      color: true,
      player_id: @player.id,
      game_id: @game.id)
    @pawn = FactoryGirl.create(
      :pawn,
      x_position: 5,
      y_position: 5,
      color: false,
      player_id: 99,
      game_id: @game.id)
  end
end
