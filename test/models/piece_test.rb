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
end
