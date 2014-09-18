class Client < ActiveRecord::Base
  has_many :projects, dependent: :destroy
  has_many :invoices, through: :projects

  belongs_to :user

  validates :name, :contact_person, presence: true

  def to_s
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
