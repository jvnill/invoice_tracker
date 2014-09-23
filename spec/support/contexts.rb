shared_context 'logged in user' do
  let!(:user) { create(:user) }

  before { cookies.signed[:auth_token] = user.auth_token }
end
