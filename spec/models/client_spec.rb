require 'rails_helper'

describe Client do
  describe 'associations and validations' do
    let!(:subject) { create(:client) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_many(:invoices) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:contact_person) }
  end

  describe '#to_s' do
    it { expect(build(:client, name: 'foo').to_s).to eql('foo') }
  end

  describe '#to_param' do
    let!(:client) { create(:client, name: 'foo') }

    it { expect(client.to_param).to eql("#{client.id}-foo") }
  end
end
