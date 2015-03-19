require 'test_helper'

class PawnTest < ActiveSupport::TestCase

  test "valid knight moves" do
    setup_knight

    assert @knight.valid_move?(5, 6)
    assert @knight.valid_move?(2, 3)
  end
 
  test "invalid knight moves" do
    setup_knight

    assert_not @knight.valid_move?(5, 5), "diagonal knight move"
    assert_not @knight.valid_move?(4, 6), "vertical knight move"
    assert_not @knight.valid_move?(5, 4), "horizontal knight move"

  end

  test "obstructed knight moves" do
    setup_knight

    assert @knight.obstructed_move?(5, 6)
    assert @white_knight.obstructed_move?(5, 1)
  end

  test "unobstructed knight moves" do
    setup_knight

    assert_not @knight.obstructed_move?(5, 2)
    assert_not @white_knight.obstructed_move?(5, 5)
    assert_not @white_knight.obstructed_move?(4, 4), "not obstructed by black knight"
  end

  def setup_knight
    @game = FactoryGirl.create(:game)
    @knight = FactoryGirl.create(:knight, x_position: 4, y_position: 4, color: false, game_id: @game.id)
    @white_knight = FactoryGirl.create(:knight, x_position: 6, y_position: 3, color: true, game_id: @game.id)
  end

end
