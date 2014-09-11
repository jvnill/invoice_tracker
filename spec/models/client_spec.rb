require 'rails_helper'

describe Client do
  let!(:subject) { create(:client) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_many(:projects) }
  it { is_expected.to have_many(:invoices) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:contact_person) }
end
