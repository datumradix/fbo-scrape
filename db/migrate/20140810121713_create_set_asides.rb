class CreateSetAsides < ActiveRecord::Migration
  def change
    create_table :set_asides do |t|
      t.string :name

      t.timestamps
    end
  end
end
