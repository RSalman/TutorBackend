require 'minitest_helper'

describe User do
  it 'creates user' do
    assert User.create!(email: 'test@test.com',
                        password: 'password',
                        uid: '123').valid?, 'User was not created'
  end
end
