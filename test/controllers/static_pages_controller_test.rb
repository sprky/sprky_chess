require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'home page loads' do
    get :index
    assert_response :success
  end

  test 'Should create array of my games' do
    setup_games

    my_games = @controller.my_games.to_a

    assert my_games.include?(@my_game1), 'Should include @my_game1'
    assert my_games.include?(@my_game2), 'Should include @my_game2'
    assert my_games.include?(@my_game3), 'Should include @my_game3'
    assert_not my_games.include?(@open_game1), 'Should not include @open_game1'
  end

  test 'Should create array of open games' do
    setup_games

    open_games = @controller.open_games.to_a

    assert_not open_games.include?(@my_game1), 'Should not include @my_game1'
    assert_not open_games.include?(@my_game2), 'Should not include @my_game2'
    assert_not open_games.include?(@my_game3), 'Should not include @my_game3'
    assert open_games.include?(@open_game1), 'Should include @open_game1'
  end

  def setup_games
    @player = FactoryGirl.create(:player)
    sign_in @player
    @opponent = FactoryGirl.create(:player)
    @my_game1 = FactoryGirl.create(:game, white_player_id: @player.id, black_player_id: nil)
    @my_game2 = FactoryGirl.create(:game, white_player_id: @player.id, black_player_id: @opponent.id)
    @my_game3 = FactoryGirl.create(:game, white_player_id: @opponent.id, black_player_id: @player.id)
    @open_game1 = FactoryGirl.create(:game, white_player_id: @opponent.id, black_player_id: nil)
  end
end
