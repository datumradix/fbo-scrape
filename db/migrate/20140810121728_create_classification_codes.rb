class CreateClassificationCodes < ActiveRecord::Migration
  def change
    create_table :classification_codes do |t|
      t.string :name

      t.timestamps
    end
  end
end
