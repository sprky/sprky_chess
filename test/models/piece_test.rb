require 'test_helper'

class PieceTest < ActiveSupport::TestCase
  test "color name" do
    piece = FactoryGirl.create(:pawn)

    piece.color = 1

    assert_equal "white", piece.color_name
  end

  test "setting default images" do
    piece = FactoryGirl.create(:pawn)
    piece.color = 0

    assert_equal "black-pawn.gif", piece.symbol
  end

  test "move on board" do
    piece = FactoryGirl.create(:pawn)

    assert_equal true, piece.move_on_board?(3, 0)
  end

  test "move isn't on board" do
    piece = FactoryGirl.create(:pawn)

    assert_equal false, piece.move_on_board?(9, 0)
  end

  test "Should mark piece as captured" do
    piece = FactoryGirl.create(:rook, x_position: 5, y_position: 4, captured?: false)
    piece.mark_captured
    piece.reload

    assert piece.captured?, "Should mark captured?: true"
    assert_nil piece.x_position, "Should be x_position: nil"
    assert_nil piece.y_position, "Should be y_position: nil"

  end

  test "Should recognize nil move" do 
    piece = FactoryGirl.create(:rook, x_position: 5, y_position: 4)

    assert piece.nil_move?(5, 4)
    assert_not piece.nil_move?(5, 5)
  end

  test "Should recognize destination_obstructed move" do 
    game = FactoryGirl.create(:game)
    piece = FactoryGirl.create(:rook, x_position: 5, y_position: 4, color: true, game_id: game.id)


    assert piece.destination_obstructed?(5, 1), "White rook obstructed by white pawn"
    assert_not piece.destination_obstructed?(5, 6), "White rook not obstructed by black pawn"
    assert_not piece.destination_obstructed?(5, 9), "Not obstructed at empty space"
  end

  test "Should recognize valid move" do 
    game = FactoryGirl.create(:game)
    piece = FactoryGirl.create(:rook, x_position: 5, y_position: 4, color: true, game_id: game.id)

    assert piece.valid_move?(7, 4)
    assert piece.valid_move?(5, 6)
  end

  test "Should recognize invalid moves" do 
    game = FactoryGirl.create(:game)
    piece = FactoryGirl.create(:rook, x_position: 5, y_position: 4, color: true, game_id: game.id)

    assert_not piece.valid_move?(5, 4), "Is nil move"
    assert_not piece.valid_move?(8, 4), "Is not on board"
    assert_not piece.valid_move?(3, 3), "Is illegal move"
    assert_not piece.valid_move?(5, 0), "Is obstructed by pawn"
    assert_not piece.valid_move?(5, 1), "Destination is obstructed by white pawn"
  end

end
