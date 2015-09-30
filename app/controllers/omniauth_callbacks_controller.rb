class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def callback
    @user = OauthAccount.from_omniauth(request.env["omniauth.auth"]).user

    if @user.present?
      set_flash_message(:notice, :success, kind: params[:action].try(:titleize)) if is_navigational_format?
      sign_in_and_redirect(@user, event: :authentication)
    else
      set_flash_message(:alert, :failure, kind: params[:action].try(:titleize), reason: "something went wrong") if is_navigational_format?
      redirect_to root_path
    end
  end

  alias_method :github, :callback
end
