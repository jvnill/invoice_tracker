class UsersController < ApplicationController
  skip_before_filter :require_current_user
  skip_before_filter :require_current_account

  def create
    @user = User.new(user_params)
    @user.save
  end

  private

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
