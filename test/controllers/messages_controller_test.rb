require "test_helper"

class MessagesControllerTest < ActionDispatch::IntegrationTest
  include JsonWebToken

  def setup
    @user = users(:david)
    @conversation = conversations(:memo)
  end

  test "should get index" do
    token = jwt_encode({ user_id: @user.id })
    conversationId = conversations(:memo).id
    get "/api/v1/conversations/#{conversationId}/messages", headers: { 'Authorization' => 'Bearer ' + token }
    assert_response :success
  end

  test 'should fail if the body is missing' do
    token = jwt_encode({ user_id: @user.id })
    post "/api/v1/conversations/#{@conversation.id}/messages", params: { body: '', user_id: @user.id, conversation_id: @conversation.id }, headers: { 'Authorization' => 'Bearer ' + token }
    assert_response :bad_request
    response_json = response.parsed_body
    assert_equal 'Unable to create message.', response_json['error']
  end

  test 'should create message' do
    token = jwt_encode({ user_id: @user.id })
    post "/api/v1/conversations/#{@conversation.id}/messages", params: { body: 'Hello William :)', user_id: @user.id, conversation_id: @conversation.id }, headers: { 'Authorization' => 'Bearer ' + token }
    assert_response :success
    data = JSON.parse(response.body)
    message = data['message']
    assert_equal 'Hello William :)', message['body']
  end
end
