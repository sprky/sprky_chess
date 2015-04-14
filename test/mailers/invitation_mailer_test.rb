require 'test_helper'

class InvitationMailerTest < ActionMailer::TestCase
  test 'shoud send invitation' do
    invitation = FactoryGirl.create(:invitation)
    email = InvitationMailer.send_invitation(invitation).deliver_now

    assert_not ActionMailer::Base.deliveries.empty?

    subject = 'Invitation: Play SPRKY Chess with jbellison@icloud.com'

    assert_equal ['no-reply@sprky.herokuapp.com'], email.from
    assert_equal ['myfriend@email.com'], email.to
    assert_equal subject, email.subject
  end
end
