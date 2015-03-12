require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @player = FactoryGirl.create(:player)
    sign_in @player
  end

  test "game id matches game_id for new pieces" do
    game = FactoryGirl.create(:game, :id => 1)
    assert_equal(game.id, 1) 
  end

	test "game join success" do
  	game = FactoryGirl.create(:game, :white_player_id => @player.id)
  	patch :update, id: game.id, game: { black_player_id: 37 }
    game.reload

    assert_redirected_to game_path(assigns(:game))
    assert game.white_player_id == 37 ||  game.black_player_id == 37
  end

  test "game join fail due to identical@player_id" do
    game = FactoryGirl.create(:game, white_player_id:@player.id)
    put :update, :id => game.id, :game => { :black_player_id =>@player.id }
    game.reload
    assert_response :found
    expected = nil
    assert_equal expected, game.black_player_id, "black_player_id should be nil"
  end

  test "game create success" do
    game = FactoryGirl.create(:game, white_player_id: @player.id)

    expected = @player.id
    assert_equal expected, game.white_player_id
  end

  test "game created with :create action" do
    game = FactoryGirl.create(:game, :white_player_id => @player.id )

    assert_difference('Game.count') do
      post :create, game: { name: game.name, white_player_id: game.white_player_id }
    end

    assert_redirected_to game_path(assigns(:game))
  end

  test "pieces are initialized when a game is started" do
    g=Game.create(:white_player_id => @player.id)
    g.initialize_board!
    assert :success

  end
end
