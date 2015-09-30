class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  # omniauth-*
  # rescue_from OAuth::Unauthorized, with: :oauth_failure

  rescue_from CanCan::AccessDenied do |exception|
    store_user_return_to_location
    respond_to_access_denied(exception)
  end

  protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up)        << [:name]
      devise_parameter_sanitizer.for(:account_update) << [:name]
    end

    def oauth_failure
      flash.keep
      redirect_to new_user_session_path, flash: { error: "Sign in failed" }
    end

    # would love to use `store_location_for(:user, location)`
    # but devise opt to strip anchor tag i.e. `/path?x=y#abc` will be stored as `/path?x=y`
    # so we're manually performing `session['user_return_to'] = ...`
    def store_user_return_to_location
      session["user_return_to"] = [
        params[:user_return_to],
        request.get? ? request.url : request.referrer,
        session["user_return_to"],
      ].find(&:present?)
    end

    def respond_to_access_denied(_exception)
      if request.format.html? && (!request.xhr?)
        if current_user
          redirect_to root_path, flash: { error: "Sorry, you're not authorized to do that." }
        else
          redirect_to new_user_session_path
        end
      else
        head :unauthorized
      end
    end
end
