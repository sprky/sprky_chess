require 'test_helper'

class QueenTest < ActiveSupport::TestCase
  
  test "queen valid moves" do
    queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)

    assert queen.valid_move?(6, 6)
    assert queen.valid_move?(4, 0)
    assert queen.valid_move?(3, 4)
  end

  test "queen invalid moves" do
    queen = FactoryGirl.create(:queen, x_position: 4, y_position: 4)

    assert_not queen.valid_move?(5, 6)
  end

end
