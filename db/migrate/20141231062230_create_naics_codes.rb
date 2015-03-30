class CreateNaicsCodes < ActiveRecord::Migration
  def change
    create_table :naics_codes do |t|
      t.string :name

      t.timestamps
    end
  end
end
