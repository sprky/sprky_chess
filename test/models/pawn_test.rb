require 'test_helper'

class PawnTest < ActiveSupport::TestCase

  # Illegal White Moves
  test "illegal white backwards move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true)
    assert_equal false, pawn.legal_move?(1, 0)
  end

  test "illegal white horizontal move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true)
    assert_equal false, pawn.legal_move?(0, 1)
  end

  test "illegal white first move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true)
    assert_equal false, pawn.legal_move?(1, 4)
  end

  test "illegal white diagonal move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true)
    assert_equal false, pawn.legal_move?(2, 2)
  end

  # Legal White Moves
  test "legal white first move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true)
    assert_equal true, pawn.legal_move?(1, 2)
  end

  test "legal white regular move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 2, color: true)
    assert_equal true, pawn.legal_move?(1, 3)
  end

  # Illegal Black Moves
  test "illegal backwards black move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 5, color: false)
    assert_equal false, pawn.legal_move?(1, 6)
  end

  test "illegal black horizontal move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6, color: false)
    assert_equal false, pawn.legal_move?(0, 6)
  end

  test "illegal black first move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6, color: false)
    assert_equal false, pawn.legal_move?(1, 3)
  end

  test "illegal black diagonal move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 5, color: false)
    assert_equal false, pawn.legal_move?(0, 4)
  end

  # Legal Black Moves
  test "legal black first move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 6, color: false)
    assert_equal true, pawn.legal_move?(1, 5)
  end

  test "legal black regular move" do
    pawn = FactoryGirl.create(:pawn, x_position: 1, y_position: 4, color: false)
    assert_equal true, pawn.legal_move?(1, 3)
  end

end
