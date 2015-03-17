require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  test "game id matches game_id for new pieces" do
    game = FactoryGirl.create(:game, :id => 1)
    assert_equal(game.id, 1) 
  end

	test "game join success" do
  	player = FactoryGirl.create(:player)
  	sign_in player

  	game = FactoryGirl.create(:game, white_player_id: player.id)
  	put :update, :id => game.id, :game => { black_player_id: 37 }
    game.reload
  	assert_response :found
  	assert game.white_player_id == 37 ||  game.black_player_id == 37
  end

  test "game join fail due to identical player_id" do
    player = FactoryGirl.create(:player)
    sign_in player

    game = FactoryGirl.create(:game, white_player_id: player.id)
    put :update, :id => game.id, :game => { :black_player_id => player.id }
    game.reload
    assert_response :found
    expected = nil
    assert_equal expected, game.black_player_id, "black_player_id should be nil"
  end

  test "game create success" do
    player = FactoryGirl.create(:player)
    sign_in player
    current_player = player

    game = FactoryGirl.create(:game, white_player_id: current_player.id)

    expected = current_player.id

    assert_equal expected, game.white_player_id
  end

  test "game created with :create action" do
    player = FactoryGirl.create(:player)
    sign_in player
    game = FactoryGirl.create(:game, :white_player_id => player.id )

    assert_difference('Game.count') do
      post :create, game: { name: game.name, white_player_id: game.white_player_id }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "pieces are initialized when a game is started" do
    player = FactoryGirl.create(:player)
    sign_in player

    g=Game.create(:white_player_id => player.id)
    g.initialize_board!
    assert :success
  end

end
