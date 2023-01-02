require "test_helper"

class ConversationsControllerTest < ActionDispatch::IntegrationTest
  include JsonWebToken

  def setup
    @sender = users(:david)
    @receiver = users(:sarah)
    @service = services(:service)
  end

  test "should get index" do
    token = jwt_encode({ user_id: @sender.id })
    get "/api/v1/conversations", headers: { 'Authorization' => 'Bearer ' + token }
    assert_response :success
  end

  test "should create conversation" do
    token = jwt_encode({ user_id: @sender.id })
    post "/api/v1/conversations", params: { sender_id: @sender.id, receiver_id: @receiver.id, service_id: @service.id }, headers: { 'Authorization' => 'Bearer ' + token }
    assert_response :success
  end

end
