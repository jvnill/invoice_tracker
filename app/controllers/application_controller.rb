class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :require_current_user

  def current_user
    return if cookies[:auth_token].blank?

    @current_user ||= User.find_by(auth_token: cookies.signed[:auth_token])
  end

  private

  def require_current_user
    return if current_user

    reset_session
    flash[:error] = I18n.t('sessions.logged_in_user_required')
    redirect_to new_session_path
  end

  def set_user_as_current_user
    @user = current_user
  end

  def respond_to_js_only
    respond_to do |format|
      format.js
    end
  end

  def login(user)
    if params[:remember_me]
      cookies.permanent.signed[:auth_token] = user.auth_token
    else
      cookies.signed[:auth_token] = user.auth_token
    end
  end
end
