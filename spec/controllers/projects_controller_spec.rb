require 'rails_helper'

describe ProjectsController do
  include_context 'logged in user'

  describe 'GET index' do
    let!(:project) { create(:project, user: user) }

    before { get :index }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:index) }
    it { expect(assigns(:projects).to_a).to eql([project]) }
  end

  describe 'GET new' do
    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
    it { expect(assigns(:project)).to be_new_record }
  end

  describe 'POST create' do
    let!(:client) { create(:client, user: user) }

    context 'valid project' do
      before { xhr :post, :create, project: attributes_for(:project).merge(client_id: client.id) }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:create) }
      it { expect(assigns(:project)).to be_persisted }
    end

    context 'invalid project' do
      before { xhr :post, :create, project: { name: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:create) }
      it { expect(assigns(:project)).to be_new_record }
    end
  end

  describe 'GET show' do
    let!(:project) { create(:project, user: user) }

    before { get :show, id: project.id }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:show) }
    it { expect(assigns(:project)).to eql(project) }
    it { expect(assigns(:invoices)).to be_empty }
  end

  describe 'GET edit' do
    let!(:project) { create(:project, user: user) }

    before { get :edit, id: project.id }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:edit) }
    it { expect(assigns(:project)).to eql(project) }
  end

  describe 'PATCH update' do
    let!(:project) { create(:project, user: user) }

    context 'valid update' do
      before { xhr :patch, :update, id: project.id, project: { name: 'New Project Name' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(project.reload.name).to eql('New Project Name') }
    end

    context 'invalid update' do
      before { xhr :patch, :update, id: project.id, project: { name: '' } }

      it { expect(response).to be_success }
      it { expect(response).to render_template(:update) }
      it { expect(assigns(:project).errors.to_a).to eql(['Name can\'t be blank']) }
    end
  end

  describe 'DELETE destroy' do
    let!(:project) { create(:project, user: user) }

    before { xhr :delete, :destroy, id: project.id }

    it { expect { project.reload }.to raise_error(ActiveRecord::RecordNotFound) }
  end
end
