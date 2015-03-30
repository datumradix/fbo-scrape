class CreateSolicitationNumbers < ActiveRecord::Migration
  def change
    create_table :solicitation_numbers do |t|
      t.string :name

      t.timestamps
    end
  end
end
