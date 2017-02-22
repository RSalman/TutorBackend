require 'test_helper'

class TutorInfoTest < ActiveSupport::TestCase
  def setup
    @user = User.new(name: 'Test')
  end

  test 'valid info' do
    info = TutorInfo.new
    @user.tutor_info = info
    assert info.valid?
  end

  test 'invalid info no user' do
    info = TutorInfo.new
    refute info.valid?, 'info is valid without user'
    assert_not_nil info.errors[:user_id],
                   'no validation error for user_id present'
  end
end
