require 'test_helper'

class TutorSubjectTest < ActiveSupport::TestCase
  def setup
    @course = Course.create(course_prefix: 'CSI', course_code: '2132',
                            course_name: 'Database I')
    @user = User.new(name: 'Test')
    @info = TutorInfo.new
    @user.tutor_info = @info
  end

  test 'valid subject' do
    subject = @info.tutor_subjects.new(rate: 1, course_id: @course.id)
    assert subject.valid?
  end

  test 'valid subject no info' do
    subject = TutorSubject.new(rate: 1, course_id: @course.id)
    refute subject.valid?, 'subject is valid without info'
    assert_not_nil subject.errors[:tutor_info_id],
                   'no validation error for tutor_info_id present'
  end

  test 'valid subject no course' do
    subject = @info.tutor_subjects.new(rate: 1)
    refute subject.valid?, 'subject is valid without course'
    assert_not_nil subject.errors[:course_id],
                   'no validation error for course_id present'
  end

  test 'invalid subject no rating' do
    subject = @info.tutor_subjects.new(course_id: @course.id)
    refute subject.valid?, 'subject is valid without rate'
    assert_not_nil subject.errors[:rate],
                   'no validation error for rate present'
  end
end
