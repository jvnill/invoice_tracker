class PaymentDetail < ActiveRecord::Base
  belongs_to :user

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :text, presence: true
end
