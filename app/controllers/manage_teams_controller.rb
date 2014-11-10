class ManageTeamsController < ApplicationController
  def index
    @current_user = current_user
    @current_team = current_team
    @user_teams = current_user.teams
    @current_public_team = Team.find(params[:current_public_team])
    @private_teams = current_user.teams.where(private: true)
    @public_team_opportunities = @current_public_team.evaluations.where(evaluation_code_id: 1).order("opportunity_id DESC").paginate(:per_page => 50, :page => params[:page]) 
  end

  def edit
    @current_user = current_user
    @current_team = current_team
    @user_teams = current_user.teams
    @public_teams = Team.where(private: nil)
    @private_teams = current_user.teams.where(private: true)
  end

  def show
  @current_user = current_user
  @current_team = current_team
  @user_teams = current_user.teams
  @public_teams = Team.where(private: nil)
  @current_public_team = Team.find(params[:team_id])
  @private_teams = current_user.teams.where(private: true)
  end

  def update 
    respond_to do |format| 
      if @current_user.update(user_params)
        format.html { redirect_to opportunities_path, notice: "updated teams!"}
      end
    end
  end

  #def drop_team(user_team)
  #  @current_user.teams.delete(user_team)
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_drop_team
      @drop_team = @current_user.teams.find(params[:id])
    end

end
