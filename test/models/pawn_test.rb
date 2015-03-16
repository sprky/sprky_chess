require 'test_helper'

class PawnTest < ActiveSupport::TestCase

  # Illegal White Moves
  test "illegal white moves" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true, game_id: game.id)
    # backwards
    assert_equal false, white_pawn.legal_move?(1, 0)
    # horizontal
    assert_equal false, white_pawn.legal_move?(0, 1)
    # first move of three
    assert_equal false, white_pawn.legal_move?(1, 4)
    # diagonal move
    assert_equal false, white_pawn.legal_move?(2, 2)
  end

  test "legal white first moves" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true, game_id: game.id)
    # first move of one
    assert_equal true, white_pawn.legal_move?(1, 2)
    # first move of two
    assert_equal true, white_pawn.legal_move?(1, 3)
  end

  test "legal white regular moves" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 2, y_position: 3, color: true, game_id: game.id)
    assert_equal true, white_pawn.legal_move?(2, 4)
  end

  test "illegal black moves" do
    game = FactoryGirl.create(:game)
    black_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6, color: false, game_id: game.id)
    # backwards
    assert_equal false, black_pawn.legal_move?(1, 7)
    # horizontal
    assert_equal false, black_pawn.legal_move?(0, 6)
    # diagonal
    assert_equal false, black_pawn.legal_move?(2, 5)
    # first move of three
    assert_equal false, black_pawn.legal_move?(1, 3)
  end

  test "legal black first moves" do
    game = FactoryGirl.create(:game)
    black_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6, color: false, game_id: game.id)
    # first move of one
    assert_equal true, black_pawn.legal_move?(1, 5)
    # first move of two
    assert_equal true, black_pawn.legal_move?(1, 4)
  end

  test "legal capture moves" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 3, color: true, game_id: game.id)
    black_pawn = FactoryGirl.create(:pawn, x_position: 2, y_position: 4, color: false, game_id: game.id)
    assert_equal true, white_pawn.legal_move?(2, 4)
    assert_equal true, black_pawn.legal_move?(1, 3)
  end

end
