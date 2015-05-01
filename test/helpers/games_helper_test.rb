require 'test_helper'

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
end
