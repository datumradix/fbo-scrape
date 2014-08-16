class CreateSelectionCriteria < ActiveRecord::Migration
  def change
    create_table :selection_criteria do |t|
      t.integer :team_id
      t.integer :set_aside_radio_id
      t.timestamps
    end

    create_table :classification_codes_selection_criteria, id: false do |t|
      t.integer :classification_code_id 
      t.integer :selection_criterium_id
      t.belongs_to :classification_code 
      t.belongs_to :selection_criterium
    end

    create_table :selection_criteria_set_asides, id: false do |t|
      t.integer :set_aside_id
      t.integer :selection_criterium_id
      t.belongs_to :set_aside
      t.belongs_to :selection_criterium
    end

    create_table :procurement_types_selection_criteria, id: false do |t|
      t.integer :procurement_type_id
      t.integer :selection_criterium_id
      t.belongs_to :procurement_type 
      t.belongs_to :selection_criterium 
    end
  end
end
