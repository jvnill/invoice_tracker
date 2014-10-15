require 'rails_helper'

describe OmniauthHandler do
  describe 'login_allowed?' do
    context 'authentication exists' do
      let!(:authentication) { create(:authentication) }
      let!(:omniauth_hash)  { { provider: authentication.provider, uid: authentication.uid }.stringify_keys }
      let!(:handler)        { OmniauthHandler.authorize(omniauth_hash) }

      it { expect(handler.login_allowed?).to eql(true) }
      it { expect(handler.user).to eql(authentication.user) }
    end

    context 'authentication doesnt exist' do
      context 'user is already in the db' do
        let!(:user)           { create(:user) }
        let!(:omniauth_hash)  { { provider: 'github', uid: '123', info: { 'email' => user.email } }.stringify_keys }
        let!(:handler)        { OmniauthHandler.authorize(omniauth_hash) }

        it { expect(handler.login_allowed?).to eql(true) }
        it { expect(handler.user).to eql(user) }
        it { expect(user.authentications.first.provider).to eql('github') }
        it { expect(user.authentications.first.uid).to eql('123') }
      end

      context 'user is not yet on the db' do
        let!(:omniauth_hash)  { { provider: 'github', uid: '123', info: { 'email' => 'jvnill@gmail.com' } }.stringify_keys }
        let!(:handler)        { OmniauthHandler.authorize(omniauth_hash) }

        it { expect(handler.login_allowed?).to eql(true) }
        it { expect(handler.user).to be_persisted }
        it { expect(handler.user.authentications.first.provider).to eql('github') }
        it { expect(handler.user.authentications.first.uid).to eql('123') }
      end
    end
  end
end
