class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.references :careplan, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
