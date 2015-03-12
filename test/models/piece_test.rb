require 'test_helper'

class PieceTest < ActiveSupport::TestCase
  test "piece is marked as captured" do
    pawn = Piece.where(:x_position => 1, :y_position => 0).last
    Piece.capture(1, 0)
    assert_equal(pawn.capture?, true)
    assert_equal(pawn.x_position, 0)
    assert_equal(pawn.y_position, 0)
  end
end
