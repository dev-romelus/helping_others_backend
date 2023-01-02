require "test_helper"

class AuthenticationControllerTest < ActionDispatch::IntegrationTest
  test 'should fail if the email is missing' do
    post '/api/v1/login', params: { email: '', password: 'azerty' }
    assert_response :unauthorized
    response_json = response.parsed_body
    assert_equal 'Your email or password invalid.', response_json['error']
  end

  test 'should fail if the password is missing' do
    post '/api/v1/login', params: { email: 'jesus@email.fr', password: '' }
    assert_response :unauthorized
    response_json = response.parsed_body
    assert_equal 'Your email or password invalid.', response_json['error']
  end

  test 'should login successfully' do
    user = users(:david)
    post '/api/v1/login', params: { email: user.email, password: 'password' }
    assert_response :success
    data = JSON.parse(response.body)
    user = data['user']
    assert_equal 'david.doe@email.fr', user['email']
  end
end
