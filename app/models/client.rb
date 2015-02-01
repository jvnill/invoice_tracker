class Client < ActiveRecord::Base
  has_many :projects, dependent: :destroy, inverse_of: :client
  has_many :invoices, through: :projects

  belongs_to :user, inverse_of: :clients

  validates :name, :contact_person, presence: true

  def to_s
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
