class PaymentDetail < ActiveRecord::Base
  belongs_to :user, inverse_of: :payment_details

  has_many :invoices, inverse_of: :payment_detail

  validates :title, presence: true, uniqueness: { scope: :user_id }
  validates :text, presence: true
end
