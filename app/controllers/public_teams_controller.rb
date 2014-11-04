class PublicTeamsController < ApplicationController

  def criteria
    @public_team = Team.find(params[:team_id])
  end

  def users
    @public_team = Team.find(params[:team_id])
  end

  def opportunities
    @public_team = Team.find(params[:team_id])
    @public_team_opportunities = @public_team.evaluations.where(evaluation_code_id: 1).order("opportunity_id DESC").paginate(:per_page => 50, :page => params[:page]) 
  end 


end
