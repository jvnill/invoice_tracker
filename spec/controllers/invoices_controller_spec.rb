require 'rails_helper'

describe InvoicesController do
  include_context 'logged in user'

  let!(:client) { create(:client, user: user) }
  let!(:project) { create(:project, client: client) }

  describe 'GET index' do
    let!(:invoice1) { create(:invoice, user: user, project: project) }
    let!(:invoice2) { create(:invoice, user: user, project: project) }

    before { get :index }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:index) }
    it { expect(assigns(:invoices).to_a).to eql([invoice2, invoice1]) }
  end

  describe 'GET new' do
    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
    it { expect(assigns(:invoice)).to be_new_record }
  end

  describe 'POST create' do
    context 'valid invoice' do
      context 'invoice items has no quantity' do
        before { xhr :post, :create, invoice: attributes_for(:invoice).merge(no_quantity: true, project_id: project.id, invoice_items_attributes: [{ name: 'II', unit_amount: 10 }]) }

        it { expect(response).to be_success }
        it { expect(response).to render_template(:create) }
        it { expect(assigns(:invoice)).to be_persisted }
        it { expect(assigns(:invoice).invoice_items.first.quantity).to eql(1) }
      end

      context 'invoice items has quantity' do
        before { xhr :post, :create, invoice: attributes_for(:invoice).merge(project_id: project.id, invoice_items_attributes: [attributes_for(:invoice_item)]) }

        it { expect(response).to be_success }
        it { expect(response).to render_template(:create) }
        it { expect(assigns(:invoice)).to be_persisted }
      end
    end

    context 'invalid invoice' do
      before { xhr :post, :create, invoice: { number: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:create) }
      it { expect(assigns(:invoice)).to be_new_record }
    end
  end

  describe 'GET show' do
    let!(:invoice) { create(:invoice, project: project, user: user) }
    let!(:invoice_item) { create(:invoice_item, invoice: invoice) }

    before { get :show, id: invoice.id }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:show) }
    it { expect(assigns(:invoice)).to eql(invoice) }
    it { expect(assigns(:project)).to eql(project) }
    it { expect(assigns(:client)).to eql(client) }
    it { expect(assigns(:invoice_items).to_a).to eql([invoice.invoice_items.first, invoice_item]) }
  end

  describe 'GET edit' do
    let!(:invoice) { create(:invoice, project: project, user: user) }

    before { get :edit, id: invoice.id }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:edit) }
    it { expect(assigns(:invoice)).to eql(invoice) }
  end

  describe 'PATCH update' do
    let!(:invoice) { create(:invoice, project: project, user: user) }

    context 'valid update' do
      before { xhr :patch, :update, id: invoice.id, invoice: { number: 999 } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(invoice.reload.number).to eql('999') }
    end

    context 'invalid update' do
      before { xhr :patch, :update, id: invoice.id, invoice: { number: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(assigns(:invoice).errors.to_a).to eql(['Number can\'t be blank']) }
    end
  end

  describe 'DELETE destroy' do
    let!(:invoice) { create(:invoice, project: project, user: user) }

    before { delete :destroy, id: invoice.id }

    it { expect(response).to redirect_to(invoices_path) }
    it { expect { invoice.reload }.to raise_error }
  end

  describe 'GET download' do
    render_views

    let!(:invoice) { create(:invoice, project: project, user: user) }

    before { get :download, id: invoice.id, preview: true }

    it { expect(response.body).to match('<body class=\'pdf\'>') }
    it { expect(response.body).to match("<dt>Invoice No:</dt>\n<dd>#{invoice.number}</dd>") }
  end

  describe 'PATCH cycle_status' do
    let!(:invoice) { create(:invoice, project: project, user: user) }

    before { xhr :patch, :cycle_status, id: invoice.id }

    it { expect(response).to be_success }
    it { expect(response.body).to eql({ status: 'Sent' }.to_json) }
    it { expect(invoice.reload.status).to eql('sent') }
  end
end
