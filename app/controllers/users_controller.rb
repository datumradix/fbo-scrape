class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  filter_resource_access

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @evaluations_with_comments = current_team.evaluations.joins(:comments).order("opportunity_id DESC").paginate(:per_page => 10, :page => params[:page])
    evaluations_pluck = current_team.evaluations.joins(:comments).pluck(:opportunity_id).uniq
    @eval_with_comments = current_team.evaluations.where(opportunity_id: evaluations_pluck).order("opportunity_id DESC").limit(20) #.paginate(:per_page => 10, :page => params[:page])

    @opportunities = current_team.evaluations.order("id DESC").paginate(:per_page => 10, :page => params[:page])

    @capture_lead_teams_watchlists = Evaluation.where(evaluation_code_id:2).order("id DESC")
  end

  # GET /users/new
  def new
    @current_team = current_team
    @user = User.new
    @teams = Team.all
    @team_to_join = Team.find(params[:team_id])
    #@user = @new_user_params
  end

  # GET /users/1/edit
  def edit
    @user = current_user
    @teams = Team.all
    @current_team = current_team
  end

  # POST /users
  # POST /users.json
  def create
    # raise params.inspect
    @user = User.new(user_params)
    #before save data sanitazation
    @current_team = current_team
    @user.username = @user.username.downcase 
    @user.email = @user.email.downcase

    @team_to_join = Team.find(user_params[:team_id])

    respond_to do |format|

      if @user.save
        format.html { redirect_to user_path(@user.id), notice: 'Registration successful.' }
        format.json { render action: 'show', status: :created, location: @user }
        @user.welcome_new_user.deliver
      else
        format.html { render action: 'new', team_id: @current_team }
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
        format.html { render action: 'edit', current_team: @current_team }
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
      params.fetch(:user, {}).permit(:username, :email, :password, :password_confirmation, :password_salt, :encrypted_password, :perishable_token, :team_id, :role_id, :team_ids => [] )
    end
end
