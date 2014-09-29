require 'rails_helper'

describe UserOption do
  describe 'associations and validations' do
    let!(:subject) { create(:user_option) }

    it { is_expected.to belong_to(:user) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:value) }
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:name) }
    it { is_expected.to ensure_inclusion_of(:name).in_array(UserOption::OPTIONS) }
  end

  describe '.create_or_initialize!' do
    let!(:user) { create(:user) }
    let!(:user_option) { create(:user_option, user: user, name: 'password_token') }

    context 'user has existing option with the given name' do
      before do
        expect {
          UserOption.create_or_initialize!(user, 'password_token', 'foofoo')
        }.to change(UserOption, :count).by(0)
      end

      it { expect(user_option.reload.value).to eql('foofoo') }
    end

    context 'user has no option with the given name' do
      before do
        expect {
          UserOption.create_or_initialize!(user, 'password_reset_at', 'foofoo')
        }.to change(UserOption, :count).by(1)
      end

      it { expect(UserOption.last.value).to eql('foofoo') }
    end
  end

  describe '#set_datatype' do
    let!(:user) { create(:user) }

    context 'name is password token' do
      let(:user_option) { build(:user_option, datatype: nil, name: 'password_token', user: user, value: 'token') }

      before { user_option.save! }

      it { expect(user_option.datatype).to eql('string') }
    end

    context 'name is password_reset_at' do
      let(:user_option) { build(:user_option, datatype: nil, name: 'password_reset_at', user: user, value: Date.today.to_s) }

      before { user_option.save! }

      it { expect(user_option.datatype).to eql('datetime') }
    end
  end
end
