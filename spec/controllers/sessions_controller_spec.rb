require 'rails_helper'

describe SessionsController do
  describe 'GET new' do
    context 'user is logged in' do
      include_context 'logged in user'

      before { get :new }

      it { expect(response).to redirect_to(invoices_path) }
    end

    context 'user is not logged in' do
      before { get :new }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:new) }
    end
  end

  describe 'POST create' do
    let!(:user) { create(:user, email: 'jim@example.com', password: 'pass') }

    context 'successful auth' do
      context 'no remember me' do
        before { post :create, email: 'jim@example.com', password: 'pass' }

        it { expect(response).to redirect_to(invoices_path) }
        it { expect(cookies.signed[:auth_token]).to eql(user.auth_token) }
      end

      context 'with remember me' do
        before { post :create, email: 'jim@example.com', password: 'pass', remember_me: true }

        it { expect(response).to redirect_to(invoices_path) }
        it { expect(cookies.signed[:auth_token]).to eql(user.auth_token) }
      end
    end

    context 'unsuccessful auth' do
      before { post :create, email: 'jim@example.com', password: 'pass1' }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:new) }
      it { expect(session[:user_id]).to be_nil }
    end
  end

  describe 'DELETE destroy' do
    include_context 'logged in user'

    before { delete :destroy }

    it { expect(session[:user_id]).to be_nil }
    it { expect(response).to redirect_to(root_path) }
  end
end
