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
    @comments = Comment.order("id DESC").paginate(:per_page => 10, :page => params[:page])
    @not_evaluated_count = Opportunity.where(management_evaluation: "Not Evaluated").count
    @watchlist_count = Opportunity.where(management_evaluation: "Watchlist").where('created_at >= ?', 1.week.ago).count
    @reject_count = Opportunity.where(management_evaluation: "Reject").where('created_at >= ?', 1.week.ago).count
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = current_user
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'Registration successful.' }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation, :role_id)
    end
end
