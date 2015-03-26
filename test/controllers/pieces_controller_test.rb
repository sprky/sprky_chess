require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
 
  # update needs to be a put, updates data
  test "should get update" do
    game = FactoryGirl.create(:game)
    piece = FactoryGirl.create(:pawn, x_position: 1, y_position: 1, color: true, game_id: game.id )

    patch :update, id: piece.id, piece: { x_position: 1, y_position: 2 }

    assert_response :success

    body = JSON.parse(response.body)
    assert_equal "/games/#{game.id}", body["update_url"]
  end

end
