class RemoveLastNameFromUsers < ActiveRecord::Migration
  def up
    remove_column :users, :last_name
    rename_column :users, :first_name, :name
  end

  def down
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
  end
end
