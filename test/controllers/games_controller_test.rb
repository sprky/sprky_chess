require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test 'game join fail due to identical player_id\'s' do
    player = FactoryGirl.create(:player)
    sign_in player
    game = FactoryGirl.create(:game, white_player_id: 3)
    patch :update, id: game.id, game: { black_player_id: 3 }
    game.reload
    assert_response :unprocessable_entity, 'Should respond unprocessable_entity'
  end

  test 'game created with :create action' do
    player = FactoryGirl.create(:player)
    sign_in player
    assert_difference('Game.count') do
      post :create, game: { name: 'game1' }
    end
    assert_redirected_to game_path(assigns(:game))
  end

  test 'guest can join game' do
    host = FactoryGirl.create(:player, id: 1)
    guest = FactoryGirl.create(:player, id: 2)
    sign_in guest

    game = FactoryGirl.create(:game, white_player_id: host.id)

    patch :update, id: game.id, game: { black_player_id: guest.id }
    game.reload

    assert_response :found
    assert_redirected_to game_path(game)
    assert_equal guest.id, game.black_player_id
    assert_equal host.id, game.white_player_id
  end
end
