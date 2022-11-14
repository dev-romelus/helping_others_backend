class UserSerializer
  include JSONAPI::Serializer
  attributes :id, :lastName, :firstName, :email, :identity_document
end
