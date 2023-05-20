module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verfied_user
    end

    protected

    def find_verfied_user
      session_token = extract_token_from_url
      user = User.find_by(session_token: session_token)
      return if user
      raise ApiError::Unauthorized
    end

    def extract_token_from_url
      query_params = URI.parse(request.url).query
      query_params_hash = Rack::Utils.parse_nested_query(query_params)
      query_params_hash['token']
    end
  end
end
