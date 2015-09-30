class OauthAccount < ActiveRecord::Base
  belongs_to :user

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |account|
      account.provider         = auth.provider
      account.uid              = auth.uid
      account.name             = auth.info.name
      account.email            = auth.info.email
      account.image_url        = auth.info.image
      account.oauth_token      = auth.credentials.token
      account.oauth_secret     = auth.credentials.secret
      account.oauth_expires_at = Time.at(auth.credentials.expires_at) if auth.credentials.expires_at

      (account.user || account.build_user).tap do |user|
        user.attributes = {
          name: account.name,
          email: account.email || auth.info.nickname || auth.extra.raw_info.username
        }
        user.confirm
        user.save(validate: false)
      end

      account.save(validate: false)
    end
  rescue StandardError
    logger.error auth.inspect
    raise
  end
end
