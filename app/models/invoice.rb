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
  before_save :update_invoice_items_qty, if: :no_quantity?

  def total_amount
    invoice_items.sum('quantity * unit_amount')
  end

  def currency
    read_attribute(:currency) || '$'
  end

  def page_size
    read_attribute(:page_size) || 'Letter'
  end

  private

  def set_as_new_invoice
    self.status ||= 'new'
  end

  def update_invoice_items_qty
    invoice_items.each { |item| item.quantity = 1 }
  end
end
