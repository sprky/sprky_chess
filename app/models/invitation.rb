class Invitation < ActiveRecord::Base
  after_create :send_email

  belongs_to :game
  belongs_to :player

  def send_email
    InvitationMailer.send_invitation(self).deliver
  end
end
