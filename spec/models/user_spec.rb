require 'rails_helper'

describe User do
  let!(:subject) { create(:user) }

  it { is_expected.to have_one(:user_detail) }
  it { is_expected.to have_many(:invoices) }
  it { is_expected.to have_many(:clients) }
  it { is_expected.to have_many(:projects).through(:clients) }
  it { is_expected.to validate_presence_of(:email) }
  it { expect(User.new).to validate_presence_of(:password).on(:create) }
end
