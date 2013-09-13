class InvoiceItem < ActiveRecord::Base
  belongs_to :invoice, inverse_of: :invoice_items

  validates :name, :unit_amount, :quantity, presence: true

  default_scope order('created_at ASC')
end
