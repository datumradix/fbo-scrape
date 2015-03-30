class AddForeignKeyIdsToOpportunities < ActiveRecord::Migration
  def change
    add_column :opportunities, :agency_id, :integer
    add_column :opportunities, :solicitation_number_id, :integer
    add_column :opportunities, :naics_code_id, :integer
    add_column :opportunities, :opportunity_type_id, :integer
  end
end
