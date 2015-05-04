require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test 'Should return piece id' do
    FactoryGirl.create(:game)
    piece = FactoryGirl.create(:pawn)

    assert_equal piece.id, piece_id(piece), 'Should return piece id'
  end

  test 'Should return nil if no piece' do
    FactoryGirl.create(:game)
    piece = nil

    assert_nil piece_id(piece)
  end
end
