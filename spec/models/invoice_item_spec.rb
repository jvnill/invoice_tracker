require 'rails_helper'

describe InvoiceItem do
  let!(:subject) { create(:invoice_item) }

  it { is_expected.to belong_to(:invoice) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:unit_amount) }
  it { is_expected.to validate_presence_of(:quantity) }
end
