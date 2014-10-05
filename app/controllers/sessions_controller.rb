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
    auth = Authentication.find_by(auth_hash_identifier)

    if auth
      user = auth.user

    else
      user = User.where(email: omniauth_user_details['email']).first_or_initialize
      if user.persisted?
        user.authentications.create!(auth_hash_identifier)
      else
        user.skipping_password = true
        unless user.save
          flash[:error] = 'There has been some errors with your user setup. Please register normally'
          reset_session
          redirect_to new_session_path
          return
        end
      end
    end

    login(user)
    redirect_to(invoices_path)
  end

  private

  def login(user)
    if params[:remember_me]
      cookies.permanent.signed[:auth_token] = user.auth_token
    else
      cookies.signed[:auth_token] = user.auth_token
    end
  end

  def omniauth_user_details
    @omniauth_user_details ||= omniauth_hash['info']
  end

  def omniauth_hash
    @omniauth_hash ||= request.env['omniauth.auth']
  end

  def auth_hash_identifier
    @auth_hash_identifier ||= { uid: omniauth_hash['uid'], provider: omniauth_hash['provider'] }
  end
end
