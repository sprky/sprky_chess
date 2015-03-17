require 'test_helper'

class PawnTest < ActiveSupport::TestCase

  test "valid knight moves" do
    game = FactoryGirl.create(:game)
    knight = FactoryGirl.create(:knight, x_position: 4, y_position: 4)

    assert knight.valid_move?(5, 6)
    assert knight.valid_move?(2, 3)
  end
 
  test "invalid knight moves" do
    game = FactoryGirl.create(:game)
    knight = FactoryGirl.create(:knight, x_position: 4, y_position: 4)
  
    assert_not knight.valid_move?(5, 5), "diagonal knight move"
    assert_not knight.valid_move?(4, 6), "vertical knight move"
    assert_not knight.valid_move?(5, 4), "horizontal knight move"

  end
end
