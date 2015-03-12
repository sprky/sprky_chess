require 'test_helper'

class RookTest < ActiveSupport::TestCase
  test "move isn't legal" do
    rook = FactoryGirl.create(:rook, x_position: 0, y_position: 0)

    assert_equal false, rook.legal_move?(3, 3)
  end

  test "move isn't valid" do
    rook = FactoryGirl.create(:rook, x_position: 0, y_position: 0)

    assert_equal false, rook.valid_move?(10, 10)
  end

  test "legal move" do
    rook = FactoryGirl.create(:rook, x_position: 0, y_position: 0)

    assert_equal true, rook.legal_move?(1, 0)
  end



end
