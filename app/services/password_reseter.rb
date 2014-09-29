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
    begin
      token = SecureRandom.urlsafe_base64
    end while UserOption.exists?(name: 'password_token', value: token)

    UserOption.create_or_initialize!(user, 'password_token', token)
  end

  def save_reset_time
    UserOption.create_or_initialize!(user, 'password_reset_at', Time.zone.now)
  end
end
