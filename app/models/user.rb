class User < ActiveRecord::Base
  ROLES = %i(admin)

  has_one :oauth_account, dependent: :delete

  delegate :image_url, to: :oauth_account, allow_nil: true

  validates_presence_of :name

  devise :registerable, :database_authenticatable, :validatable,
         :confirmable, :rememberable,
         :recoverable, :trackable,
         :omniauthable

  rolify

  devise :omniauthable, omniauth_providers: [:github]

  # Getter/Setter to get/set role for a user on users#new/#edit pages
  # Assumes that each user only has one role
  def role
    roles.first.name.to_sym if roles.present?
  end

  def role=(new_role)
    roles_name.each { |role_name| remove_role(role_name) }
    add_role(new_role)
  end
end
