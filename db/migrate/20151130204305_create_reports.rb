class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.references :activity, index: true, polymorphic: true
      t.references :patient, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :alert
      t.text :notes

      t.timestamps null: false
    end
  end
end
