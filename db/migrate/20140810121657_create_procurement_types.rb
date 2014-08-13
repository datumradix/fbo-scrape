class CreateProcurementTypes < ActiveRecord::Migration
  def change
    create_table :procurement_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
