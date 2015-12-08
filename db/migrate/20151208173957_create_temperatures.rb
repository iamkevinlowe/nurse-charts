class CreateTemperatures < ActiveRecord::Migration
  def change
    create_table :temperatures do |t|
      t.references :vital, index: true, foreign_key: true
      t.float :celsius

      t.timestamps null: false
    end
  end
end
