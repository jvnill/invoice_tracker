ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  address: 'smtp.mandrillapp.com',
  port: 587,
  user_name: ENV['MAILER_USER_NAME'],
  password: ENV['MAILER_PASSWORD'],
  authentication: 'plain'
}
