require 'test_helper'

class KingTest < ActiveSupport::TestCase

  test "legal moves" do
    game = FactoryGirl.create(:game)
    king = FactoryGirl.create(:king, x_position: 4, y_position: 0)

    assert king.legal_move?(4, 1)
    assert king.legal_move?(5, 1)
  end

  test "illegal moves" do
    game = FactoryGirl.create(:game)
    king = FactoryGirl.create(:king, x_position: 4, y_position: 0)

    assert_not king.legal_move?(6, 0)
    assert_not king.legal_move?(4, 3)
  end

end
