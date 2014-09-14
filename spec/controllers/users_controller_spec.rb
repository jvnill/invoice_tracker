require 'rails_helper'

describe UsersController do
  describe 'GET new' do
    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
  end

  describe 'POST create' do
    context 'valid user' do
      before { xhr :post, :create, user: { email: 'jim@example.com', password: 'pass' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:create) }
      it { expect(assigns(:user)).to be_persisted }
      it { expect(session[:user_id]).to be_present }
      it { expect(flash[:success]).to eql(I18n.t('users.create_success')) }
    end

    context 'invalid user' do
      before { xhr :post, :create, user: { email: '', password: 'pass' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:create) }
      it { expect(assigns(:user)).to_not be_persisted }
      it { expect(session[:user_id]).to be_nil }
    end
  end

  describe 'GET edit' do
    include_context 'logged in user'

    before { get :edit, id: 'foo' }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:edit) }
  end

  describe 'PATCH update' do
    include_context 'logged in user'

    context 'valid update' do
      before { xhr :patch, :update, id: 'foo', user: { user_detail_attributes: { name: 'Jim' } } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(user.reload.user_detail.name).to eql('Jim') }
      it { expect(flash[:notice]).to eql(I18n.t('users.update_success')) }
    end

    context 'invalid update' do
      before { xhr :patch, :update, id: 'foo', user: { email: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(controller.current_user.errors.to_a).to eql(["Email can't be blank"]) }
    end
  end
end
