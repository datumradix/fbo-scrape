class TeamMembersController < ApplicationController
  filter_resource_access
  def index
    @team_members = User.where(team_id:current_team.id).order("role_id")

    @not_evaluated_count = current_team.evaluations.where(evaluation_code_id: 1).count
    @watchlist_count = current_team.evaluations.where(evaluation_code_id: 2).count
    @reject_count = current_team.evaluations.where(evaluation_code_id: 3).count
  end
end
