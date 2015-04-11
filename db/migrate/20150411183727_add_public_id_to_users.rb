class AddPublicIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :public_id, :uuid, null: false, default: "uuid_generate_v4()"
  end
end
