class Invoice < ActiveRecord::Base
  STATUSES = %w[new sent paid void]

  has_many :invoice_items, dependent: :destroy, inverse_of: :invoice

  belongs_to :user
  belongs_to :project

  accepts_nested_attributes_for :invoice_items

  validates :project_id, :user_id, :date, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :invoice_items, presence: true

  before_validation :set_as_new_invoice
  after_save :generate_html

  private

  def set_as_new_invoice
    self.status ||= 'new'
  end

  def generate_html
  end
end
