require 'test_helper'

class PawnTest < ActiveSupport::TestCase
  test "illegal white first move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1)
    assert_equal false, pawn.legal_move?(1, 4)
  end

  test "legal white first move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1)
    assert_equal true, pawn.legal_move?(1, 2)
  end

  test "legal black first move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6)
    assert_equal true, pawn.legal_move?(1, 5)
  end

  test "illegal black first move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6)
    assert_equal false, pawn.legal_move?(1, 3)
  end

  test "legal white regular move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 2)
    assert_equal true, pawn.legal_move?(1, 3)
  end

end
