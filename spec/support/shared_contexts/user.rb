RSpec.shared_context "when user has signed in" do
  let!(:session_token) { generate_fake_session_token }
  let!(:user) { create(:user, session_token: session_token) }
  let!(:headers) { { 'Authorization' => "Bearer #{user.session_token}" } }

  before do
    @current_user = user
    session = {}
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(session)
    session[:session_token] = session_token
  end
end
