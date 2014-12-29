class Notifier < ActionMailer::Base
  default from: "matt@teamfbo.com"

  def welcome(user)
    @user = user
    @new_session_url = new_user_session_url(name: @user.username)
    mail(to: user.email, subject: "Welcome to teamFBO")
  end

  def deliver_password_reset_instructions(user)
    @username = user.username
    @edit_password_reset_url = edit_password_reset_url(user.perishable_token) 
    mail(to: user.email, subject: "teamFBO Password Reset Instructions")
  end

  def status_report(current_user)
    @user = current_user
    @team = Team.find(@user.team_id)

    @not_evaluated = @team.evaluations.where(evaluation_code_id: 1)
    @watchlist = @team.evaluations.where(evaluation_code_id: 2)


    @new_session_url = new_user_session_url(name: @user.username)
    @edit_password_reset_url = edit_password_reset_url(current_user.perishable_token) 

    mail(to: current_user.email, subject: "teamFBO status report")
  end

end
