class InvitationMailer < ActionMailer::Base
  default from: 'no-reply@sprky.herokuapp.com'

  def send_invitation(invitation)
    @url = "http://sprky.herokuapp.com/games/#{invitation.game.id}"
    @url += '/invitations'
    @guest_email = invitation.guest_player_email

    host = Player.find(invitation.player_id)
    @host_email = host.email

    mail(
      to: "#{@guest_email}",
      subject: "Invitation: Play SPRKY Chess with #{@host_email}")
  end
end
