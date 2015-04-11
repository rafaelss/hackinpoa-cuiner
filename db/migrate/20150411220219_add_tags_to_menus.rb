class AddTagsToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :tags, :string, array: true, default: []
  end
end
