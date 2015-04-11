class SplitNameOnUsers < ActiveRecord::Migration
  def up
    rename_column :users, :name, :first_name
    add_column :users, :last_name, :string
  end

  def down
    remove_column :users, :last_name
    rename_column :users, :first_name, :name
  end
end
