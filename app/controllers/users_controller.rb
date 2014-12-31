class UsersController < ApplicationController
  skip_before_action :require_current_user, only: [:new, :create]

  def create
    @user = User.new(user_params)

    if @user.save
      login(@user)
      flash[:success] = I18n.t('users.create_success')
    end
  end

  def edit
    current_user.build_user_detail if current_user.user_detail.nil?
  end

  def update
    if current_user.update_attributes(user_params)
      flash.now[:success] = I18n.t('users.update_success')
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, user_detail_attributes: [:name, :address1, :address2, :address3, :country, :postal_code, :contact_number])
  end
end
