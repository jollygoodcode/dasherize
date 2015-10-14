class AddBackColumnsToOauthAccounts < ActiveRecord::Migration
  def change
    add_column :oauth_accounts, :email, :string
    add_column :oauth_accounts, :image_url, :string
    add_column :oauth_accounts, :oauth_secret, :string
    add_column :oauth_accounts, :oauth_expires_at, :string
  end
end
