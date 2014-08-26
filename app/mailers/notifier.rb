class Notifier < ActionMailer::Base
  default from: "matt@teamfbo.com"

  def welcome(user)
    mail(to: user.email, subject: "Welcome to teamFBO")
  end

  def deliver_password_reset_instructions(user)
    @username = user.username
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token) 
    mail(to: user.email, subject: "teamFBO Password Reset Instructions")
  end

end
