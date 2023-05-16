RSpec.shared_context "when user has signed in" do
  let!(:user) { create(:user) }

  before do
    @current_user = user
    session = {}
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return(session)
    session[:session_token] = user.reset_session_token!
  end
end
