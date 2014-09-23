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
    cookies.delete(:auth_token, domain: :all)
    reset_session
    redirect_to root_path
  end

  private

  def login(user)
    if params[:remember_me]
      cookies.permanent.signed[:auth_token] = { value: user.auth_token, domain: :all }
    else
      cookies.signed[:auth_token] = { value: user.auth_token, domain: :all }
    end
  end
end
