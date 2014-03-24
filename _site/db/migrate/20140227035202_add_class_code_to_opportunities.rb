class AddClassCodeToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :class_code, :string
  end
end
