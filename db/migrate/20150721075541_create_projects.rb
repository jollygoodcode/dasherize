class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.references :user
      t.string :repo_name
      t.string :codeship_uuid

      t.timestamps null: false
    end
  end
end
