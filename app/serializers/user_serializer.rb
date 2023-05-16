class UserSerializer < ApplicationSerializer
  USER_ATTRS = %i(
    email
    session_token
  ).freeze

  attributes *USER_ATTRS
end
