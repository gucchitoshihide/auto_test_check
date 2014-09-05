class Announce < ActionMailer::Base
  default from: "from@example.com"

  def resend_password(user)
    @user = user

    mail to: user.email, subject: 'Resend password'
  end
end
