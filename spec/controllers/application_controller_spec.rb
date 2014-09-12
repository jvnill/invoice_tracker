require 'rails_helper'

describe ApplicationController do
  controller do
    def index
    end
  end

  describe 'require_current_user' do
    before do
      session[:test] = 'foo'
      get :index
    end

    it { expect(response).to redirect_to(new_session_path) }
    it { expect(session[:test]).to be_nil }
    it { expect(flash[:error]).to eql(I18n.t('sessions.logged_in_user_required')) }
  end
end
