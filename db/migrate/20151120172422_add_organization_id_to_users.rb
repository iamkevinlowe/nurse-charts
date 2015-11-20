class AddOrganizationIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hospital_id, :integer
    add_index :users, :hospital_id
  end
end
