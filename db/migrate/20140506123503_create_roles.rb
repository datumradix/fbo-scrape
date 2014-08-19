class CreateRoles < ActiveRecord::Migration
=begin
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
  end
end
=end

  def change
    create_table :roles do |t|
      t.string :title
      t.references :user 

      t.timestamps
    end
  end
end

