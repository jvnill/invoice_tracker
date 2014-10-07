class User < ActiveRecord::Base
  has_secure_password validations: false

  has_one :user_detail

  has_many :invoices, dependent: :destroy
  has_many :clients, dependent: :destroy
  has_many :projects, through: :clients
  has_many :user_options, dependent: :destroy
  has_many :authentications, dependent: :destroy

  accepts_nested_attributes_for :user_detail

  validates :password, presence: true, on: :create, unless: :skipping_password?
  validates :email, presence: true, length: { within: 6..100, if: :email_present? }, format: { with: /\A[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}\z/i, if: :email_present? }

  after_create :set_auth_token

  attr_accessor :skipping_password

  private

  def skipping_password?
    !!skipping_password
  end

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
