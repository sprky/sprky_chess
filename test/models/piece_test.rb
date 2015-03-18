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

end
