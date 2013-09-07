class User < ActiveRecord::Base
  attr_accessor :password

  has_one :user_detail

  has_many :invoices
  has_many :projects
  has_many :clients

  before_create :encrypt_password

  validates :password, presence: true, on: :create
  validates :email, presence: true, length: { within: 6..100, if: :email_present? }, format: { with: /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i, if: :email_present? }

  def valid_password?(password)
    hashed_password == Digest::SHA2.hexdigest("#{salt}#{password}")
  end

  private

  def encrypt_password
    self.salt = SecureRandom.base64(8)
    self.hashed_password = Digest::SHA2.hexdigest("#{salt}#{password}")
  end

  def email_present?
    email.present?
  end
end
