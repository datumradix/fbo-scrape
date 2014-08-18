class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|     
      t.integer :evaluation_code_id
      t.integer :opportunity_id
      t.integer :team_id

      t.timestamps
    end
  end
end


