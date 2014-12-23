class CreateSearchKeywords < ActiveRecord::Migration
  def change
    create_table :search_keywords do |t|
      t.integer :team_id
      t.string :name

      t.timestamps
    end
  end
end
