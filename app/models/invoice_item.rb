class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice, inverse_of: :invoice_items

  validates :name, :unit_amount, :quantity, presence: true

  scope :ordered_by_id, -> { order('invoice_items.id ASC') }
end
