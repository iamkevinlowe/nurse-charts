class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :room_number
      t.references :hospital, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
