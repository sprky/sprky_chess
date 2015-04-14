class InvitationMailer < ActionMailer::Base
  default from: 'no-reply@sprky.herokuapp.com'

  def send_invitation(invitation)
    @url = "http://sprky.herokuapp.com/games/#{invitation.game.id}"
    @host_player = invitation.player.email
    @guest_player = invitation.guest_player_email

    mail(
      to: "#{@guest_player}",
      subject: "Invitation: Play SPRKY Chess with #{@host_player}")
  end
end
