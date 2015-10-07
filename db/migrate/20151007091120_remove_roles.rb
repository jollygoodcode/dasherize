class RemoveRoles < ActiveRecord::Migration
  def change
    drop_table :roles
    drop_table :users_roles
  end
end
