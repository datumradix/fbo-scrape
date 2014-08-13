class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name
      t.text :description
      t.integer :team_lead_id

      t.timestamps
    end
  end
end
