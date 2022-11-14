require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include JsonWebToken

  test "should get index" do
    token = jwt_encode({ user_id: users(:david).id })
    get "/api/v1/conversations", headers: { 'Authorization' => 'Bearer ' + token }
    assert_response :success
  end

end
