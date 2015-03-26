require 'test_helper'

class PawnTest < ActiveSupport::TestCase

  test "illegal white moves" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true, game_id: game.id)
    # backwards
    assert_not white_pawn.legal_move?(1, 0)
    # horizontal
    assert_not white_pawn.legal_move?(0, 1)
    # first move of three
    assert_not white_pawn.legal_move?(1, 4)
    # diagonal move
    assert_not white_pawn.legal_move?(2, 2)
  end

  test "legal white first moves" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true, game_id: game.id)
    # first move of one
    assert white_pawn.legal_move?(1, 2)
    # first move of two
    assert white_pawn.legal_move?(1, 3)
  end

  test "legal white regular moves" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 2, y_position: 3, color: true, game_id: game.id)
    assert white_pawn.legal_move?(2, 4)
  end

  test "illegal black moves" do
    game = FactoryGirl.create(:game)
    black_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6, color: false, game_id: game.id)
    # backwards
    assert_not black_pawn.legal_move?(1, 7)
    # horizontal
    assert_not black_pawn.legal_move?(0, 6)
    # diagonal
    assert_not black_pawn.legal_move?(2, 5)
    # first move of three
    assert_not black_pawn.legal_move?(1, 3)
  end

  test "legal black first moves" do
    game = FactoryGirl.create(:game)
    black_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6, color: false, game_id: game.id)
    # first move of one
    assert black_pawn.legal_move?(1, 5)
    # first move of two
    assert black_pawn.legal_move?(1, 4)
  end

  test "should capture" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 3, color: true, game_id: game.id)
    black_pawn = FactoryGirl.create(:pawn, x_position: 2, y_position: 4, color: false, game_id: game.id)
    assert white_pawn.capture_move?(2, 4)
    assert black_pawn.capture_move?(1, 3)
  end

  test "should not capture" do
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 3, color: true, game_id: game.id)
    white_pawn_2 = FactoryGirl.create(:pawn, x_position: 2, y_position: 4, color: true, game_id: game.id)
    
    assert_not white_pawn.capture_move?(2, 4)
  end

  test "should not be obstructed" do 
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true, game_id: game.id)
    black_pawn = FactoryGirl.create(:pawn, x_position: 2, y_position: 6, color: false, game_id: game.id)
    middle_pawn = FactoryGirl.create(:pawn, x_position: 6, y_position: 4, color: false, game_id: game.id)

    assert_not white_pawn.obstructed_move?(1, 3), "White 2 square initial move"
    assert_not white_pawn.obstructed_move?(1, 2), "White 1 square initial move"
    assert_not black_pawn.obstructed_move?(2, 5), "Black 1 sqaure initial move"
    assert_not middle_pawn.obstructed_move?(6, 3), "Black 1 square regular move"
  end 

  test "should be obstructed" do 
    game = FactoryGirl.create(:game)
    white_pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true, game_id: game.id)
    black_pawn = FactoryGirl.create(:pawn, x_position: 5, y_position: 6, color: false, game_id: game.id)
    blocking_piece1 = FactoryGirl.create(:knight, x_position: 1, y_position: 2, color: false, game_id: game.id)
    blocking_piece2 = FactoryGirl.create(:knight, x_position: 5, y_position: 5, color: false, game_id: game.id)

    assert white_pawn.obstructed_move?(1, 3), "White 2 square initial move"
    assert black_pawn.obstructed_move?(5, 4), "Black 2 square initial move"
  end 
end
