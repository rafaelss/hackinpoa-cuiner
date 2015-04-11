class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.belongs_to :user, null: false, index: true
      t.uuid :public_id, null: false, default: "uuid_generate_v4()"
      t.string :name, null: false
      t.decimal :price, null: false, precision: 10, scale: 2
      t.decimal :price_per_person, null: false, precision: 10, scale: 2
      t.numrange :number_of_people, null: false
      t.timestamps null: false
    end
  end
end
