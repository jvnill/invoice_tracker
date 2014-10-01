class Invoice < ActiveRecord::Base
  STATUSES = %w[new sent paid void]
  PAGE_SIZES = %w[A4]

  has_many :invoice_items, dependent: :destroy, inverse_of: :invoice

  belongs_to :user
  belongs_to :project

  accepts_nested_attributes_for :invoice_items, allow_destroy: true

  validates :project_id, :user_id, :date, :number, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :currency, length: { maximum: 4 }
  validates :page_size, inclusion: { in: PAGE_SIZES }
  validates :invoice_items, presence: true

  before_validation :set_as_new_invoice

  scope :ordered_by_id, -> { order('invoices.id DESC') }

  def total_amount
    invoice_items.sum('quantity * unit_amount')
  end

  def currency
    read_attribute(:currency).presence || '$'
  end

  def page_size
    read_attribute(:page_size).presence || 'A4'
  end

  def next_status
    STATUSES[(STATUSES.index(status) + 1) % 4]
  end

  private

  def set_as_new_invoice
    self.status ||= 'new'
  end
end
