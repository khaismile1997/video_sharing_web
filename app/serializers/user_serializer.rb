class UserSerializer < ApplicationSerializer
  USER_ATTRS = %i(
    username
    email
  ).freeze

  attributes :id, *USER_ATTRS
end
