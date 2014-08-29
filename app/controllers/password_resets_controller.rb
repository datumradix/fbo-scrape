class PasswordResetsController < ApplicationController
  # Method from: http://github.com/binarylogic/authlogic_example/blob/master/app/controllers/application_controller.rb
  before_filter :require_no_user
  before_filter :load_user_using_perishable_token, :only => [ :edit, :update ]

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.deliver_password_reset_instructions.deliver
      flash[:notice] = "Instructions to reset your password have been emailed to you"
      redirect_to password_resets_path
    else
      flash.now[:error] = "No user was found with email address #{params[:email]}"
      render :action => :new
    end
  end

  def edit
  end

  def update
    # Use @user.save_without_session_maintenance instead if you
    # don't want the user to be signed in automatically.
    #if @user.save
    @user = User.find_by(:perishable_token => params[:id])
    
    if password_reset_params[:password].present?
      if @user.update(password_reset_params)
        flash[:success] = "Your password was successfully updated"
        redirect_to new_user_session_path(name: @user.username)
      else
        render :action => :edit
      end
    else
      @user.errors.add(:password, "cannot be blank") 
      render :action => :edit
    end
  end


  private

  def load_user_using_perishable_token
    @user = User.find_using_perishable_token(params[:id])
    unless @user
      flash[:error] = "We're sorry, but we could not locate your account"
      redirect_to root_url
    end
  end

  def password_reset_params
      params.require(:password_resets).permit(:password, :password_confirmation)
  end
end