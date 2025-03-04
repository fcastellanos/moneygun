class RenameAccountsToOrganizations < ActiveRecord::Migration[8.1]
  def change
    rename_table :accounts, :organizations
    rename_table :organization_users, :memberships
    rename_column :memberships, :organization_id, :organization_id
    rename_column :inboxes, :organization_id, :organization_id
  end
end
