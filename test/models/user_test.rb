require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.new(first_name: 'best', last_name: 'test', email: 'test@uottawa.ca', password: 'supersecurePassword',
                    phone_number: '6135223652')
    assert user.valid?
  end
end
