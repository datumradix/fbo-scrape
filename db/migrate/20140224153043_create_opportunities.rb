class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.text :opportunity
      t.string :agency
      t.string :opp_type
      t.date :post_date
      t.date :response_date
      t.string :link
      t.text :comments
      t.integer :like, :default => 0

      t.timestamps
    end
  end
end
