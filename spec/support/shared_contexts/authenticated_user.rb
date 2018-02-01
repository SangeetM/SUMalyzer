RSpec.shared_context 'authenticated_user' do
  let(:user) { create(:user) }
  before { sign_in user }
end
