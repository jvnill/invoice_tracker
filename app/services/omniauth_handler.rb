class OmniauthHandler
  attr_reader :user

  def self.authorize(omniauth_hash)
    new(omniauth_hash['uid'], omniauth_hash['provider'], omniauth_hash['info'])
  end

  def initialize(uid, provider, user_info)
    @user_details         = user_info
    @auth_hash_identifier = { uid: uid, provider: provider }

    process_user

    self
  end

  def login_allowed?
    !!user
  end

  private

  attr_reader :user_details, :auth_hash_identifier

  def process_user
    if authentication
      @user = authentication.user

    else
      find_or_create_user_from_email
    end
  end

  def authentication
    @authentication ||= Authentication.find_by(auth_hash_identifier)
  end

  def find_or_create_user_from_email
    user = User.where(email: user_details['email']).first_or_initialize

    if user.save(validate: false)
      @user = user
      user.authentications.create!(auth_hash_identifier)
    end
  end
end
