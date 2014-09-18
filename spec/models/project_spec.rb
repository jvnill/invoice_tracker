require 'rails_helper'

describe Project do
  describe 'associations and validations' do
    let!(:subject) { create(:project) }

    it { is_expected.to have_many(:invoices) }
    it { is_expected.to belong_to(:client) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:client_id) }
  end

  describe '#to_s' do
    it { expect(build(:project, name: 'foo').to_s).to eql('foo') }
  end

  describe '#to_param' do
    let!(:project) { create(:project, name: 'foo') }

    it { expect(project.to_param).to eql("#{project.id}-foo") }
  end
end
