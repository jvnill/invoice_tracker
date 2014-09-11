require 'rails_helper'

describe Project do
  let!(:subject) { create(:project) }

  it { is_expected.to have_many(:invoices) }
  it { is_expected.to belong_to(:client) }
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:client_id) }
end
