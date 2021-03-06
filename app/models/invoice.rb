class Invoice < ActiveRecord::Base
  STATUSES = %w[new sent paid void]
  PAGE_SIZES = %w[A4]

  has_many :invoice_items, dependent: :destroy, inverse_of: :invoice

  belongs_to :user,           inverse_of: :invoices
  belongs_to :project,        inverse_of: :invoices
  belongs_to :payment_detail, inverse_of: :invoices

  accepts_nested_attributes_for :invoice_items, allow_destroy: true

  validates :project_id, :user_id, :date, :number, presence: true
  validates :status, presence: true, inclusion: { in: STATUSES }
  validates :currency, length: { maximum: 4 }
  validates :page_size, inclusion: { in: PAGE_SIZES }
  validates :invoice_items, presence: true

  before_validation :set_as_new_invoice
  before_save :calculate_invoice_total

  scope :ordered_by_id, -> { order('invoices.id DESC') }

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

  def calculate_invoice_total
    self.total_amount = invoice_items.sum('quantity * unit_amount')
  end
end
