class CreateEvaluationCodes < ActiveRecord::Migration
  def change
    create_table :evaluation_codes do |t|
      t.string :name

      t.timestamps
    end
  end
end
