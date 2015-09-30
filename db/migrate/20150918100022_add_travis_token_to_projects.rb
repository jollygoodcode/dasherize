class AddTravisTokenToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :travis_token, :string
  end
end
