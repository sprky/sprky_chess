require 'test_helper'

class GamesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

	test "game join success" do
  	player = FactoryGirl.create(:player)
  	sign_in player

  	@game = FactoryGirl.create(:game)
  	put :update, :id => @game, :game => { :black_player_id => 37 }

  	assert_response :found
  	assert 37, @game.black_player_id
  end

end
