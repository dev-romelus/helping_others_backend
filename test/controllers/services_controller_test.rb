require "test_helper"

class ServicesControllerTest < ActionDispatch::IntegrationTest
  include JsonWebToken

  def setup
    @user = users(:david)
    @service = services(:service)
  end

  test "should get all services" do
    token = jwt_encode({ user_id: @user.id })
    get "/api/v1/services", headers: { 'Authorization' => 'Bearer ' + token }
    assert_response :success
  end

  test "should get a service" do
    token = jwt_encode({ user_id: @user.id })
    get "/api/v1/services/#{@service.id}", headers: { 'Authorization' => 'Bearer ' + token }
    assert_response :success
  end

  test "should create a service" do
    token = jwt_encode({ user_id: @user.id })

    post "/api/v1/services", 
    params: { 
      title: 'Stretch the lawn',
      request_type: 'occasional_tasks',
      latitude: 56,
      longitude: 2.41,
      user_id: @user.id
    },
    headers: { 'Authorization' => 'Bearer ' + token }

    assert_response :created
    service = JSON.parse(response.body)
    assert_equal 'Stretch the lawn', service['title']
  end

  test "should update a service" do
    token = jwt_encode({ user_id: @user.id })

    put "/api/v1/services/#{@service.id}", 
    params: { 
      title: 'Car wash',
      request_type: @service.request_type,
      latitude: @service.latitude,
      longitude: @service.longitude,
      user_id: @user.id
    }, 
    headers: { 'Authorization' => 'Bearer ' + token }

    assert_response :success
    service = JSON.parse(response.body)
    assert_equal 'Car wash', service['title']
  end
end
