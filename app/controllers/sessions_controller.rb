class SessionsController < ApplicationController
  skip_before_action :require_current_user

  def new
    redirect_to invoices_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      login(user)
      redirect_to invoices_path

    else
      flash.now[:error] = I18n.t('sessions.login_error')
      render :new
    end
  end

  def destroy
    cookies.delete(:auth_token)
    reset_session
    redirect_to root_path
  end

  def omniauth_callback
    handler = OmniauthHandler.authorize(request.env['omniauth.auth'])

    if handler.login_allowed?
      login(handler.user)
      redirect_to(invoices_path)

    else
      reset_session
      flash[:error] = I18n.t('sessions.omniauth_error')
      redirect_to new_session_path
    end
  end

  private

  def login(user)
    if params[:remember_me]
      cookies.permanent.signed[:auth_token] = user.auth_token
    else
      cookies.signed[:auth_token] = user.auth_token
    end
  end
end
