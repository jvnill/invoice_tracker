class PasswordsMailer < ActionMailer::Base
  def reset_instructions(user)
    mail to: user.email,
       from: 'jvnill@gmail.com',
    subject: 'Reset password instructions for Simple Invoice Tracker'
  end
end
