class Project < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :repo_name
end
