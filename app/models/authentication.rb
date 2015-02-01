class Authentication < ActiveRecord::Base
  belongs_to :user, inverse_of: :authentications

  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true, uniqueness: { scope: :user_id }
end
