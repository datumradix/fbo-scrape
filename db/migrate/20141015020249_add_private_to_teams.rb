class AddPrivateToTeams < ActiveRecord::Migration
  def change
    add_column :teams, :private, :boolean
  end
end
