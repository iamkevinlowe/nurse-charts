class CreateCareplans < ActiveRecord::Migration
  def change
    create_table :careplans do |t|
      t.references :patient, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
