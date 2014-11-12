class TeamsController < ApplicationController
  before_action :set_team, only: [:show, :edit, :update, :destroy]
  filter_resource_access

  # GET /teams
  # GET /teams.json
  def index
    @public_teams = Team.where(private: nil)
    #@companies_with_public_teams = Team.where(private: nil).group(:company_id)
    @companies_with_public_teams = Team.where(private: nil).select("DISTINCT ON (company_id) *")
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @current_team = current_team

    @not_evaluated_count = current_team.evaluations.where(evaluation_code_id: 1).count
    @watchlist_count = current_team.evaluations.where(evaluation_code_id: 2).count
    @reject_count = current_team.evaluations.where(evaluation_code_id: 3).count
  end

  # GET /teams/new
  def new
    @team = Team.new
    @users = User.all
    @opportunities = Opportunity.all
    @company_radios = Company.all
  end

  # GET /teams/1/edit
  def edit
    @users = User.all
    @opportunities = Opportunity.all
    @company_radios = Company.all
  end

  # POST /teams
  # POST /teams.json
  def create
    @team = Team.new(team_params)

    respond_to do |format|
      if @team.save
        format.html { redirect_to root_path, notice: 'Team was successfully created.' }
        format.json { render action: 'show', status: :created, location: @team }
      else
        format.html { render action: 'new' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /teams/1
  # PATCH/PUT /teams/1.json
  def update
    respond_to do |format|
      if @team.update(team_params)
        format.html { redirect_to user_path(current_user), notice: 'Team information was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @team.destroy
    respond_to do |format|
      format.html { redirect_to teams_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_team
      @team = Team.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def team_params
      params.require(:team).permit(:name, :description, :company_id, :opportunity_ids => [], :team_ids => [])
    end
end
