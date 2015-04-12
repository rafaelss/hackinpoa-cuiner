class CreateAbsences < ActiveRecord::Migration
  def change
    create_table :absences do |t|
      t.belongs_to :user, null: false, index: true
      t.datetime :at, null: false
      t.string :shift, null: false
      t.timestamps null: false
    end
  end
end
