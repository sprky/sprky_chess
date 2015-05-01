require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test 'shoud send invitation' do
    game = FactoryGirl.create(:game, id: 77)
    player = FactoryGirl.create(:player, id: 77)
    invitation = FactoryGirl.create(
      :invitation,
      game_id: game.id,
      player_id: player.id,
      player: player,
      guest_player_email: 'myfriend@email.com')

    email = InvitationMailer.send_invitation(invitation).deliver

    assert_not ActionMailer::Base.deliveries.empty?

    subject = 'Invitation: Play SPRKY Chess with ' + "#{player.email}"
    expected_body = '<p>Click here to join the game: '
    expected_body += '<a href="http://sprky.herokuapp.com/games/77/invitations">'
    expected_body += 'http://sprky.herokuapp.com/games/77/invitations</a>'
    expected_body += '</p><p>Good luck,</p><p>SPRKY</p>'

    assert_equal ['no-reply@sprky.herokuapp.com'], email.from
    assert_equal ['myfriend@email.com'], email.to
    assert_equal subject, email.subject
    assert_equal expected_body, email.body.raw_source
  end
end
