class PasswordsController < ApplicationController
  skip_before_action :require_current_user

  def create
    user = User.find_by(email: params[:email])

    PasswordReseter.new(user).process if user
  end
end
