class PasswordsMailer < ActionMailer::Base
  def reset_instructions(user)
    @user = user
    @token = @user.user_options.find_by(name: 'password_token')

    mail to: @user.email,
       from: 'jvnill@gmail.com',
    subject: 'Reset password instructions for Simple Invoice Tracker'
  end
end
