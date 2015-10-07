class User < ActiveRecord::Base
  has_one :oauth_account, dependent: :delete

  delegate :image_url, to: :oauth_account, allow_nil: true

  validates_presence_of :name

  devise :registerable, :database_authenticatable, :validatable,
         :confirmable, :rememberable,
         :recoverable, :trackable,
         :omniauthable

  devise :omniauthable, omniauth_providers: [:github]
end
