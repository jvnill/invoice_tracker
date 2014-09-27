class PasswordsController < ApplicationController
  skip_before_action :require_current_user

  def create
    user = User.find_by(email: params[:email])

    PasswordsMailer.reset_instructions(user).deliver if user
  end
end
