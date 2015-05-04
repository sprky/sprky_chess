require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  test 'game join success' do
    player = FactoryGirl.create(:player)
    sign_in player
    game = FactoryGirl.create(:game, white_player_id: player.id)
    patch :update, id: game.id, game: { black_player_id: 37 }
    game.reload
    assert_response :found
    assert_redirected_to game_path(assigns(:game))
    # method exists to randomize which player is white and which is black
    # for this reason either color may end up being player 37
    assert game.white_player_id == 37 ||  game.black_player_id == 37
  end

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

  test 'update should be successful' do
    game = FactoryGirl.create(
      :game,
      id: 1,
      white_player_id: 1)
    black_player = FactoryGirl.create(:player, id: 2)
    sign_in black_player

    patch :update,
          id: game.id,
          game: { black_player_id: 2 }

    assert_redirected_to game_path(game)
  end

  test 'should assign pieces after update' do
    white_player = FactoryGirl.create(:player, id: 1)

    game = FactoryGirl.create(
      :game,
      white_player_id: white_player.id)

    black_player = FactoryGirl.create(:player, id: 2)
    sign_in black_player

    black_piece = game.pieces.where(color: false).first

    patch :update,
          id: game.id,
          game: { black_player_id: black_player.id }

    black_piece.reload

    assert_equal black_player.id, black_piece.player_id
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

  test 'Should return to dashboard for unknown game' do
    player = FactoryGirl.create(:player)
    sign_in player

    get :show, id: 99

    assert_redirected_to dashboard_path
  end
end
