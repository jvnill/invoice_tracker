class PasswordsMailer < ActionMailer::Base
  def reset_instructions(user)
    @user = user
    @token = @user.user_options.find_by(name: 'password_token')

    mail to: @user.email,
       from: 'jvnill@gmail.com',
    subject: I18n.t('emails.subjects.reset_instructions')
  end
end
