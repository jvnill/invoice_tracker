class PasswordReseter
  def initialize(user)
    @user = user
  end

  def process
    setup_reset_token
    save_reset_time

    PasswordsMailer.reset_instructions(user).deliver
  end

  private

  attr_reader :user

  def setup_reset_token
    UserOption.create_or_initialize!(user, 'password_token', SecureRandom.urlsafe_base64)
  end

  def save_reset_time
    UserOption.create_or_initialize!(user, 'password_reset_at', Time.zone.now)
  end
end
