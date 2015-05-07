require 'test_helper'
include ApplicationHelper

class GamesHelperTest < ActionView::TestCase
  test 'should return correct game message' do
    this_game = FactoryGirl.create(
      :game,
      white_player_id: 1,
      black_player_id: 2,
      turn: 1)

    expected = 'White turn'

    assert_equal expected, game_message(this_game)
  end

  test 'should return piece_image' do
    player = FactoryGirl.create :player, id: 1

    game = FactoryGirl.create(:game, white_player_id: player.id)
    piece = FactoryGirl.create :rook

    expected = '<img alt="White rook" src="/images/white-rook.svg" />'

    assert_equal expected, piece_image(game, player, piece.type)
  end

  test 'Should return correct gameboard td for empty square' do
    expected = "<td class='x-position-1'' data-x-position='1' data-y-position='6' data-piece-id='' data-piece-type=''></td>"

    assert_equal expected, gameboard_td(nil, 1, 6)
  end

  test 'Should return correct gameboard td for occupied square' do
    knight = FactoryGirl.create(:knight, color: false)
    expected = "<td class='x-position-6'' data-x-position='6' data-y-position='7' data-piece-id='#{knight.id}' data-piece-type='#{knight.type}'><img alt=\"Black knight\" src=\"/images/black-knight.svg\" /></td>"

    assert_equal expected, gameboard_td(knight, 6, 7)
  end
end
