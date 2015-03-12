require 'test_helper'

class PieceTest < ActiveSupport::TestCase
  test "piece is marked as captured" do
    pawn = Piece.where(:x_position => 1, :y_position => 1).last
    Piece.capture(1, 1)
    assert_equal(pawn.capture?, true)
    assert_equal(pawn.x_position, nil)
    assert_equal(pawn.y_position, nil)
  end
end
