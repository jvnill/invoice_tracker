require 'rails_helper'

describe PasswordReseter do
  let!(:user)    { create(:user) }
  let!(:reseter) { PasswordReseter.new(user) }
  let!(:mailer)  { double }

  describe '#process' do
    before do
      allow(mailer).to receive(:deliver)
      allow(PasswordsMailer).to receive(:reset_instructions).with(user).and_return(mailer)

      reseter.process
    end

    it { expect(user.user_options.find_by(name: 'password_token')).to_not be_nil }
    it { expect(user.user_options.find_by(name: 'password_reset_at')).to_not be_nil }
  end
end
