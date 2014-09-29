require 'rails_helper'

describe PasswordsController do
  describe 'GET new' do
    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST create' do
    let!(:user)    { create(:user) }
    let!(:reseter) { double }

    before do
      allow(reseter).to receive(:process)
      allow(PasswordReseter).to receive(:new).with(user).and_return(reseter)

      xhr :post, :create, email: user.email
    end

    it { expect(response).to be_success }
    it { expect(response).to render_template(:create) }
  end

  describe 'GET edit' do
    let!(:user)        { create(:user) }
    let!(:user_option) { create(:user_option, user: user, name: 'password_token') }

    before { get :edit, id: user_option.value }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:edit) }
    it { expect(assigns(:user)).to eql(user) }
  end

  describe 'PATCH update' do
    let!(:user)        { create(:user) }
    let!(:user_option) { create(:user_option, user: user, name: 'password_token') }

    context 'valid update' do
      before { xhr :patch, :update, id: user_option.value, user: { password: 'test', password_confirmation: 'test' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(assigns(:user)).to eql(user) }
      it { expect(assigns(:user).errors).to be_empty }
    end

    context 'invalid update' do
      before { xhr :patch, :update, id: user_option.value, user: { password: 'test', password_confirmation: 't' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(assigns(:user)).to eql(user) }
      it { expect(assigns(:user).errors[:password_confirmation]).to eql(['doesn\'t match Password']) }
    end
  end
end
