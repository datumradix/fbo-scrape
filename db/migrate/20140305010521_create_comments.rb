class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :comment
      t.string :name
      t.belongs_to :evaluation, index: true

      t.timestamps
    end
  end
end
