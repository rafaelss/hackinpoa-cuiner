class ChangeNumberOfPeopleToArrayOnMenus < ActiveRecord::Migration
  def up
    remove_column :menus, :number_of_people
    add_column :menus, :number_of_people, :integer, array: true, null: false, default: []
  end

  def down
    remove_column :menus, :number_of_people, :integer
    add_column :menus, :number_of_people, :numrange
  end
end
