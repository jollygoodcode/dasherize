class RemoveColumnsFromOauthAccountsAndUsers < ActiveRecord::Migration
  def change
    remove_column :oauth_accounts, :email, :string
    remove_column :oauth_accounts, :image_url, :string
    remove_column :oauth_accounts, :oauth_secret, :string
    remove_column :oauth_accounts, :oauth_expires_at, :string
  end
end
