class CreateOauthAccounts < ActiveRecord::Migration
  def change
    create_table :oauth_accounts do |t|
      t.string :provider
      t.string :uid
      t.string :name
      t.string :email
      t.string :image_url
      t.string :oauth_token
      t.string :oauth_secret
      t.string :oauth_expires_at

      t.references :user, index: true

      t.timestamps
    end
  end
end
