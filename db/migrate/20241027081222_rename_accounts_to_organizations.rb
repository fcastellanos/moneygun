class RenameAccountsToOrganizations < ActiveRecord::Migration[8.0]
  def change
    rename_table :accounts, :organizations
    rename_table :organization_users, :memberships
    rename_column :memberships, :organization_id, :organization_id
    rename_column :projects, :organization_id, :organization_id
  end
end
