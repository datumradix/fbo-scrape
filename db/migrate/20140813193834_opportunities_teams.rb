class OpportunitiesTeams < ActiveRecord::Migration
  def change
    create_table :opportunities_teams, :id => false do |t|
      t.integer :opportunity_id 
      t.integer :team_id
    end
  end
end
