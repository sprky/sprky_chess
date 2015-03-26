require 'test_helper'

class PiecesControllerTest < ActionController::TestCase
 
  # update needs to be a put, updates data
  # test "should get update" do
  #   get :update
  #   assert_response :success
  # end

  test "Should update game with piece move" do 
    setup_piece

    xhr :put, :update, id: @knight.id, piece: { id: @knight.id, x_position: 2, y_position: 2}
    
    @knight.reload
    assert_equal 2, @knight.x_position, "Knight should register move"
    
    expected_response = "/games/#{@game.id}" 
    assert_equal expected_response, json_response['update_url'], "Should respond with json of game path"

  end

  test "Should fail update move for invalid move" do 
    setup_piece    

    xhr :put, :update, id: @knight.id, piece: { id: @knight.id, x_position: 3, y_position: 1}
    
    @knight.reload
    assert_equal 1, @knight.x_position, "Knight should not register move"
    
    expected_response = "/games/#{@game.id}" 
    assert_equal expected_response, json_response['update_url'], "Should respond with json of game path"


  end

  def json_response
    ActiveSupport::JSON.decode @response.body
  end

  def setup_piece
    @game = FactoryGirl.create(:game)
    @knight = @game.pieces.where(x_position: 1, y_position: 0).last

  end

end
