class CreateOpportunities < ActiveRecord::Migration
  def change
    create_table :opportunities do |t|
      t.text :opportunity
      t.text :opportunity_description
      #t.text :class_code
      t.string :agency
      t.string :opp_type
      t.date :post_date
      t.date :response_date
      t.string :link
      #t.text :description
      t.text :comments
      t.string :management_evaluation 
      t.integer :like, :default => 0

      t.timestamps
    end
  end
end
