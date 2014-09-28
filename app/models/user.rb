class User < ActiveRecord::Base
  has_secure_password

  has_one :user_detail

  has_many :invoices
  has_many :clients
  has_many :projects, through: :clients
  has_many :user_options

  accepts_nested_attributes_for :user_detail

  validates :password, presence: true, on: :create
  validates :email, presence: true, length: { within: 6..100, if: :email_present? }, format: { with: /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i, if: :email_present? }

  after_create :set_auth_token

  private

  def email_present?
    email.present?
  end

  def set_auth_token
    begin
      self.auth_token = SecureRandom.urlsafe_base64
    end while User.exists?(auth_token: auth_token)

    update_column :auth_token, auth_token
  end
end
