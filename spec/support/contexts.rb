shared_context 'logged in user' do
  let!(:user) { create(:user) }

  before { session[:user_id] = user.id }
end
