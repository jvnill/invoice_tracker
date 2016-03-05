require 'rails_helper'

describe Invoice do
  describe 'associations and validations' do
    let!(:subject) { create(:invoice) }

    it { is_expected.to have_many(:invoice_items) }
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:project) }

    it { is_expected.to validate_presence_of(:project_id) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:date) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:invoice_items) }
    it { is_expected.to ensure_inclusion_of(:status).in_array(Invoice::STATUSES) }
    it { is_expected.to ensure_inclusion_of(:page_size).in_array(Invoice::PAGE_SIZES) }
    it { is_expected.to ensure_length_of(:currency).is_at_most(4) }
  end

  describe '.ordered_by_id' do
    let!(:invoice1) { create(:invoice) }
    let!(:invoice2) { create(:invoice) }

    it { expect(Invoice.ordered_by_id.to_a).to eql([invoice2, invoice1]) }
  end

  describe '#total_amount' do
    let!(:invoice) { create(:invoice) }
    let!(:invoice_item) { create(:invoice_item, invoice: invoice, quantity: 1.5, unit_amount: 10) }

    before { invoice.save }

    it { expect(invoice.total_amount).to eql(25) }
  end

  describe '#currency' do
    it { expect(create(:invoice, currency: 'L').currency).to eql('L') }
    it { expect(create(:invoice, currency: '').currency).to eql('$') }
  end

  describe '#page_size' do
    it { expect(create(:invoice).page_size).to eql('A4') }
  end

  describe '#next_status' do
    it { expect(Invoice.new(status: 'new').next_status).to eql('sent') }
    it { expect(Invoice.new(status: 'sent').next_status).to eql('paid') }
    it { expect(Invoice.new(status: 'paid').next_status).to eql('void') }
    it { expect(Invoice.new(status: 'void').next_status).to eql('new') }
  end
end
