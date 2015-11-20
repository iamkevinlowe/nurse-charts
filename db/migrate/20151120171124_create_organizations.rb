class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :phone

      t.timestamps null: false
    end
  end
end
