class CreateVitals < ActiveRecord::Migration
  def change
    create_table :vitals do |t|
      t.references :patient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
