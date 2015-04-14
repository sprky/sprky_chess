class InviteMailer < ActionMailer::Base
  default from: "no-reply@sprky.heroku-app.com"

  def send_invite
    # @game = invitation.game
    # @url = 'http://sprky.heroku-app.com/games/@game.id'
    # @host_player = invitation
    # @guest_player = invitation.guest_player
    # @invited_player = invitation.invited_player

    mail(
      to: 'jbellison@icloud.com',
      subject: "Invitation: Play SPRKY Chess with #{@host_player}...") 
  end
end


