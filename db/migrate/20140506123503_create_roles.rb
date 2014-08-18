class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name

      t.timestamps
    end
  end
end

=begin
  def change
    create_table :roles do |t|
      t.string :title
      t.references :user 
    end
  end
end
=end
