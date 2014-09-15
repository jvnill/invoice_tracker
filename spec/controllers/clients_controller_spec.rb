require 'rails_helper'

describe ClientsController do
  include_context 'logged in user'

  describe 'GET index' do
    let!(:client) { create(:client, user: user) }

    before { get :index }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:index) }
    it { expect(assigns(:clients).to_a).to eql([client]) }
  end

  describe 'GET new' do
    before { xhr :get, :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
    it { expect(assigns(:client)).to be_new_record }
  end

  describe 'POST create' do
    context 'valid client' do
      before { xhr :post, :create, client: attributes_for(:client) }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:create) }
      it { expect(assigns(:client)).to be_persisted }
    end

    context 'invalid client' do
      before { xhr :post, :create, client: { name: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:create) }
      it { expect(assigns(:client)).to be_new_record }
    end
  end

  describe 'GET show' do
    let!(:client) { create(:client, user: user) }

    before { get :show, id: client.id }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:show) }
    it { expect(assigns(:client)).to eql(client) }
  end

  describe 'GET edit' do
    let!(:client) { create(:client, user: user) }

    before { xhr :get, :edit, id: client.id }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:edit) }
    it { expect(assigns(:client)).to eql(client) }
  end

  describe 'PATCH update' do
    let!(:client) { create(:client, user: user) }

    context 'valid update' do
      before { xhr :patch, :update, id: client.id, client: { name: 'New Client Name' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(client.reload.name).to eql('New Client Name') }
    end

    context 'invalid update' do
      before { xhr :patch, :update, id: client.id, client: { name: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(assigns(:client).errors.to_a).to eql(['Name can\'t be blank']) }
    end
  end

  describe 'DELETE destroy' do
    let!(:client) { create(:client, user: user) }

    before { xhr :delete, :destroy, id: client.id }

    it { expect { client.reload }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
