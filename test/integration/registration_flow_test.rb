require 'test_helper'

class RegistrationFlowTest < ActionDispatch::IntegrationTest
  test "users index" do
    get "/api/v1/users"
    assert_response 200
  end
end
