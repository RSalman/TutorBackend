require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(first_name: "Best", last_name: "tester", email: "test@uottawa.ca", password: "supersecurePassword", phone_number: "6135213652")
    assert user.valid?
  end
end
