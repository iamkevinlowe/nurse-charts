class CreateBloodPressures < ActiveRecord::Migration
  def change
    create_table :blood_pressures do |t|
      t.references :vital, index: true, foreign_key: true
      t.float :systolic
      t.float :diastolic

      t.timestamps null: false
    end
  end
end
