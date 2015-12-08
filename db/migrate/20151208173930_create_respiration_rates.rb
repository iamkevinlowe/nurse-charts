class CreateRespirationRates < ActiveRecord::Migration
  def change
    create_table :respiration_rates do |t|
      t.references :vital, index: true, foreign_key: true
      t.integer :bpm

      t.timestamps null: false
    end
  end
end
