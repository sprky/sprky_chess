require 'test_helper'

class InvitationsControllerTest < ActionController::TestCase
  test 'should create' do
    game = FactoryGirl.create(:game)
    player = FactoryGirl.create(:player)
    sign_in player
    assert_difference('Invitation.count') do
      post :create,
           invitation: {
             guest_player_email: 'bob@gmail.com',
             player_id: player.id },
           game_id: game.id
    end

    assert_redirected_to game_path(game.id, assigns(:invitaton))
  end

  test 'should have player_id' do
    game = FactoryGirl.create(:game)
    player = FactoryGirl.create(:player)
    sign_in player

    post :create,
         invitation: {
           guest_player_email: 'bob@gmail.com',
           player_id: player.id },
         game_id: game.id

    assert_equal player.id, game.invitations.last.player_id
  end
end
