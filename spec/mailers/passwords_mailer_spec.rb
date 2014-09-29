require 'rails_helper'

describe PasswordsMailer do
  describe 'reset_instructions' do
    let!(:user) { create(:user) }
    let!(:user_option) { create(:user_option, user: user, name: 'password_token', value: 'value') }

    before { PasswordsMailer.reset_instructions(user).deliver }

    it { expect(ActionMailer::Base.deliveries.size).to eql(1) }
    it { expect(ActionMailer::Base.deliveries.first.to).to include(user.email) }
    it { expect(ActionMailer::Base.deliveries.first.subject).to eql(I18n.t('emails.subjects.reset_instructions')) }
  end
end
