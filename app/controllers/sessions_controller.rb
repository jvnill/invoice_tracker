class SessionsController < ApplicationController
  skip_before_action :require_current_user

  def new
    redirect_to invoices_path if current_user
  end

  def create
    if user = User.find_by(email: params[:email])
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to invoices_path
        return
      end
    end

    flash.now[:error] = I18n.t('sessions.login_error')
    render :new
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
