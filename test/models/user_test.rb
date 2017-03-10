require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(email: "test@uottawa.ca", name: "tester", password: "supersecurePassword")
    assert user.valid?
  end
end
