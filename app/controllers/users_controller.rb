class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  filter_resource_access

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  #def team_index
  #  @team_members = User.where(team_id:current_user.team_id)
  #end
#make a new team_members controller

  # GET /users/1
  # GET /users/1.json
  def show
    @evaluations_with_comments = current_user.team.evaluations.where(evaluation_code_id: 2).order("id DESC").paginate(:per_page => 10, :page => params[:page])
    @not_evaluated_count = current_user.team.evaluations.where(evaluation_code_id: 1).count
    @watchlist_count = current_user.team.evaluations.where(evaluation_code_id: 2).count
    @reject_count = current_user.team.evaluations.where(evaluation_code_id: 3).count
    @capture_lead_teams_watchlists = Evaluation.where(evaluation_code_id:2).order("id DESC")
  end

  # GET /users/new
  def new
    @user = User.new
    #@user = @new_user_params
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.json
  def create
    #raise
    @user = User.new(user_params)
    #before save data sanitazation
    @user.username = @user.username.downcase 
    @user.email = @user.email.downcase
    respond_to do |format|

      if @user.save
        format.html { redirect_to root_path, notice: 'Registration successful.' }
        format.json { render action: 'show', status: :created, location: @user }
        @user.welcome_new_user.deliver
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find(params[:id])
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_path(current_user), notice: 'Successfully updated profile.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = current_user
    end

    def new_user_from_params 
      @user = User.new(user_params)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params  #replaced require with fetch
      params.fetch(:user, {}).permit(:username, :email, :password, :password_confirmation, :password_salt, :encrypted_password, :perishable_token, :team_id, :role_id )
    end
end
