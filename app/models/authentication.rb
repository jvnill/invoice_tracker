class Authentication < ActiveRecord::Base
  belongs_to :user

  validates :uid, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true, uniqueness: { scope: :user_id }
end
