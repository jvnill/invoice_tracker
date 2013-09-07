class Project < ActiveRecord::Base
  has_many :invoices, dependent: :destroy

  belongs_to :client

  validates :name, :client_id, presence: true
end
