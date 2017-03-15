require 'test_helper'

class PendingTutorRequestTest < ActiveSupport::TestCase
  def setup
    @course = Course.create(course_prefix: 'CSI', course_code: '2132', course_name: 'Database I')
    @user = User.create(first_name: 'tom', last_name: 'brady', email: 'tb@gmail.com', password: 'securepass',
                        phone_number: '6135265547')
    @subject = @user.tutor_subjects.create(rate: 1, course_id: @course.id)
  end

  test 'valid request' do
    request = PendingTutorRequest.create!(student_id: @user.id, tutor_id: @user.id, tutor_subject_id: @subject.id)
    assert request.valid?
  end

  test 'invalid request no subject' do
    request = PendingTutorRequest.create(student_id: @user.id, tutor_id: @user.id)
    refute request.valid?, 'request is valid with no subject'
    assert_not_empty request.errors[:tutor_subject], 'no validation error for no subject'
  end

  test 'invalid request no student' do
    request = PendingTutorRequest.create(tutor_id: @user.id, tutor_subject_id: @subject.id)
    refute request.valid?, 'request is valid with no student'
    assert_not_empty request.errors[:student], 'no validation error for no student'
  end

  test 'invalid request no tutor' do
    request = PendingTutorRequest.create(student_id: @user.id, tutor_subject_id: @subject.id)
    refute request.valid?, 'request is valid with no tutor'
    assert_not_empty request.errors[:tutor], 'no validation error for no tutor'
  end
end
