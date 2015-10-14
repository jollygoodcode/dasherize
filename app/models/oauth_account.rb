class OauthAccount < ActiveRecord::Base
  belongs_to :user

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_initialize.tap do |account|
      account.provider         = auth.provider
      account.uid              = auth.uid
      account.name             = auth.info.name
      account.oauth_token      = auth.credentials.token

      (account.user || account.build_user).tap do |user|
        user.attributes = {
          name: auth.info.name || auth.info.nickname || auth.extra.raw_info.name,
          email: auth.info.email || auth.extra.email
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

  def oauth_token=(token)
    self[:oauth_token] = self.class.crypt.encrypt_and_sign(token)
  end

  def oauth_token
    encrypted_token = self[:oauth_token]

    if encrypted_token.present?
      self.class.crypt.decrypt_and_verify(encrypted_token)
    end
  end

  private

    def self.crypt
      ActiveSupport::MessageEncryptor.new(Rails.application.secrets.secret_key_base)
    end
end
