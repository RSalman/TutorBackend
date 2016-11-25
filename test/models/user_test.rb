require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'should not save user without name or email' do
    user = User.new
    user.name = 'Test'
    assert_not user.save, "Saved #{user} without a name or email"
    user = User.new
    user.email = 'Test'
    assert_not user.save, "Saved #{user} without a name or email"
  end
end
