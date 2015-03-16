require 'test_helper'

class BishopTest < ActiveSupport::TestCase
	
  test "Bishop legal moves"  do
    setup_bishop
    
    assert @bishop.legal_move?(6, 7)
    assert @bishop.legal_move?(1, 2)
    assert @bishop.legal_move?(1, 6)
    assert @bishop.legal_move?(5, 6)
  end

  test "Bishop illegal moves" do
    setup_bishop

    assert_not @bishop.legal_move?(5, 7)
    assert_not @bishop.legal_move?(3, 7)
    assert_not @bishop.legal_move?(1, 4)
  end

  def setup_bishop
    @bishop = FactoryGirl.create(:bishop, x_position: 3, y_position: 4, color: true)
  end

end
