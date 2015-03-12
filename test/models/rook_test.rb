require 'test_helper'

class RookTest < ActiveSupport::TestCase
  test "move isn't legal" do
    rook = FactoryGirl.create(:rook, x_position: 0, y_position: 0)

    assert_equal false, rook.legal_move?(3, 3)
  end

end
