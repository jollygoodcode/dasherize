class AddCiTypeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :ci_type, :string
  end
end
