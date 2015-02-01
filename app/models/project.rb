class Project < ActiveRecord::Base
  has_many :invoices, dependent: :destroy, inverse_of: :project

  belongs_to :client, inverse_of: :projects

  has_one :user, through: :client

  validates :name, :client_id, presence: true

  def to_s
    name
  end

  def to_param
    "#{id}-#{name.parameterize}"
  end
end
