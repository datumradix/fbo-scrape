class TeamMembersController < ApplicationController
  filter_resource_access
  def index
    @team_members = User.where(team_id:current_team.id).order("role_id")
  end
end
