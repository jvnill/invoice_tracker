class SessionsController < ApplicationController
  skip_before_filter :require_current_user
  skip_before_filter :require_current_account

  def create
    if user = User.where(email: params[:email]).first
      if user.valid_password?(params[:password])
        session[:user_id] = user.id
        redirect_to invoices_path
        return
      end
    end

    flash.now[:error] = I18n.t('sessions.login_error')
    render :new
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end
end
