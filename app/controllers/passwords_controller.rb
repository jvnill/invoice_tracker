class PasswordsController < ApplicationController
  skip_before_action :require_current_user

  before_action :fetch_user_from_option, only: %i[edit update]

  def create
    user = User.find_by(email: params[:email])

    PasswordReseter.new(user).process if user
  end

  def update
    if @user.update_attributes(user_params)
      flash[:notice] = I18n.t('passwords.reset_successful')
    end
  end

  private

  def fetch_user_from_option
    @user = UserOption.find_by!(name: 'password_token', value: params[:id]).user
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
