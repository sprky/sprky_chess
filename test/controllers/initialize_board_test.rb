require 'test_helper'

class GamesControllerTest < ActionController::TestCase
	
  test "pieces are initialized when a game is started" do
  	g=Game.last
  	g.initialize_board!
  	assert :success

  end

end