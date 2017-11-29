require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'valid user' do
    user = User.create(email: 'test@uottawa.ca', password: 'supersecurePassword', phone_number: '6135223652')
    assert user.valid?
  end

  test 'invalid user no email' do
    user = User.create(password: 'supersecurePassword', phone_number: '6135223652')
    refute user.valid?, 'user is valid with no email'
    assert_not_empty user.errors[:email], 'no validation error for no email'
  end

  test 'invalid user no phone number' do
    begin
      User.create(email: 'test@uottawa.ca', password: 'supersecurePassword')
      assert false
    rescue
      assert true
    end
  end

  test 'invalid user no password' do
    user = User.create(email: 'test@uottawa.ca', phone_number: '6135223652')
    refute user.valid?, 'user is valid with no password'
    assert_not_empty user.errors[:password], 'no validation error for no password'
  end

  test 'invalid non-unique phone number' do
    user = User.create!(email: 'test@uottawa.ca', password: 'supersecurePassword', phone_number: '6135223652')
    assert user.valid?
    begin
      # TODO: Look into why if the email is the same as above, create succeeds
      User.create(email: 'test2@uottawa.ca', password: 'supersecurePassword', phone_number: '6135223652')
      assert false
    rescue
      assert true
    end
  end
end
