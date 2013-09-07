class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user

  before_filter :require_current_user

  def current_user
    return if session[:user_id].blank?

    @current_user ||= User.where(id: session[:user_id]).first
  end

  private

  def require_current_user
    destroy_session if current_user.blank?
  end

  def destroy_session
    session.delete :user_id
    redirect_to new_session_path, error: 'Please use a valid account'
  end

  def set_user_as_current_user
    @user = current_user
  end
end
