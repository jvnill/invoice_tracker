require 'rails_helper'

describe PasswordsController do
  describe 'GET new' do
    before { get :new }

    it { expect(response).to be_success }
    it { expect(response).to render_template(:new) }
  end
end
