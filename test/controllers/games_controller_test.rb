require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

	test "game join success" do
    player = FactoryGirl.create(:player)
    sign_in player
  	game = FactoryGirl.create(:game, :white_player_id => player.id)
  	patch :update, id: game.id, game: { black_player_id: 37 }
    game.reload
  	assert_response :found
    assert_redirected_to game_path(assigns(:game))
    # method exists to randomize which player is white and which is black
    # for this reason either color may end up being player 37
    assert game.white_player_id == 37 ||  game.black_player_id == 37
  end

  test "game join fail due to identical@player_id" do
    player = FactoryGirl.create(:player)
    sign_in player
    game = FactoryGirl.create(:game, white_player_id: 3, black_player_id: 0)
    put :update, :id => game.id, :game => { :black_player_id => 3 }
    game.reload
    assert_response :unprocessable_entity, "Should respond unprocessable_entity"
    assert_nil game.black_player_id, "black_player_id should be nil"
  end

  test "game created with :create action" do
    player = FactoryGirl.create(:player)
    sign_in player
    assert_difference('Game.count') do
      post :create, game: { name: "game1" }
    end
    assert_redirected_to game_path(assigns(:game))
  end

end
