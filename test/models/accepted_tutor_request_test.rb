require 'test_helper'

class AcceptedTutorRequestTest < ActiveSupport::TestCase
  def setup
    @course = Course.create(course_prefix: 'CSI', course_code: '2132', course_name: 'Database I')
    @user = User.create(first_name: 'tom', last_name: 'brady', email: 'tb@gmail.com', password: 'securepass',
                        phone_number: '6135265547')
    @subject = @user.tutor_subjects.create(rate: 1, course_id: @course.id)
  end

  test 'valid request' do
    request = AcceptedTutorRequest.create!(tutor_subject_id: @subject.id)
    assert request.valid?
    request = AcceptedTutorRequest.create!(tutor_subject_id: @subject.id, student_rating: 1, tutor_rating: 5)
    assert request.valid?
  end

  test 'invalid request no subject' do
    request = AcceptedTutorRequest.create
    refute request.valid?, 'request is valid with no subject'
    assert_not_empty request.errors[:tutor_subject], 'no validation error for no subject'
  end

  test 'invalid request ratings out-of-bounds' do
    request = AcceptedTutorRequest.create(tutor_subject_id: @subject.id, student_rating: 0, tutor_rating: 0)
    refute request.valid?, 'request is valid with non-positive ratings'
    assert_not_empty request.errors[:student_rating], 'no validation error for non-positive ratings'
    assert_not_empty request.errors[:tutor_rating], 'no validation error for non-positive ratings'
    request = AcceptedTutorRequest.create(tutor_subject_id: @subject.id, student_rating: 6, tutor_rating: 6)
    refute request.valid?, 'request is valid with ratings too high'
    assert_not_empty request.errors[:student_rating], 'no validation error for ratings too high'
    assert_not_empty request.errors[:tutor_rating], 'no validation error for ratings too high'
  end
end
