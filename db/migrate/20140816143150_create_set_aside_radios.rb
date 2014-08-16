class CreateSetAsideRadios < ActiveRecord::Migration
  def change
    create_table :set_aside_radios do |t|
      t.string :name

      t.timestamps
    end
  end
end
