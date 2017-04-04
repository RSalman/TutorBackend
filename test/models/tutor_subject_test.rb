require 'test_helper'

class TutorSubjectTest < ActiveSupport::TestCase
  def setup
    @course = Course.create(course_prefix: 'CSI', course_code: '2132', course_name: 'Database I')
    @user = User.create(first_name: 'tom', last_name: 'brady', email: 'tb@gmail.com', password: 'securepass',
                        phone_number: '6135265547')
  end

  test 'valid subject' do
    subject = @user.tutor_subjects.create!(rate: 1, course_id: @course.id)
    assert subject.valid?
  end

  test 'invalid subject rate' do
    subject = @user.tutor_subjects.create(rate: 0, course_id: @course.id)
    refute subject.valid?, 'subject is valid with non-positive rate'
    assert_not_empty subject.errors[:rate], 'no validation error for non-positive rate'
    subject = @user.tutor_subjects.create(course_id: @course.id)
    refute subject.valid?, 'subject is valid without rate'
    assert_not_empty subject.errors[:rate], 'no validation error for rate present'
  end

  test 'invalid subject no user' do
    subject = TutorSubject.create(rate: 1, course_id: @course.id)
    refute subject.valid?, 'subject is valid without info'
    assert_not_empty subject.errors[:user], 'no validation error for user_id present'
  end

  test 'invalid subject no course' do
    subject = @user.tutor_subjects.create(rate: 1)
    refute subject.valid?, 'subject is valid without course'
    assert_not_empty subject.errors[:course], 'no validation error for course_id present'
  end
end
