class AddCircleciTokenToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :circleci_token, :string
  end
end
