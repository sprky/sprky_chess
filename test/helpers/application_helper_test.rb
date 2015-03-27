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

  test 'Should return correct gameboard td for empty square' do
    expected = "<td class='x-position-1'' data-x-position='1' data-y-position='6' data-piece-id=''></td>"

    assert_equal expected, gameboard_td(nil, 1, 6)
  end

  test 'Should return correct gameboard td for occupied square' do
    knight = FactoryGirl.create(:knight, color: false)
    expected = "<td class='x-position-6'' data-x-position='6' data-y-position='7' data-piece-id='#{knight.id}'><img alt=\"Black knight\" src=\"/images/black-knight.gif\" /></td>"

    assert_equal expected, gameboard_td(knight, 6, 7)
  end
end
