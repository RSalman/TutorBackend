require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'valid course' do
    course = Course.new(course_prefix: 'CSI', course_code: '2132',
                        course_name: 'Database I')
    assert course.valid?
  end

  test 'invalid without prefix' do
    course = Course.new(course_code: '2132', course_name: 'Database I')
    refute course.valid?, 'course is valid without prefix'
    assert_not_nil course.errors[:course_prefix],
                   'no validation error for course_prefix present'
  end

  test 'invalid without code' do
    course = Course.new(course_prefix: 'CSI', course_name: 'Database I')
    refute course.valid?, 'course is valid without code'
    assert_not_nil course.errors[:course_code],
                   'no validation error for course_code present'
  end

  test 'invalid without name' do
    course = Course.new(course_prefix: 'CSI', course_code: '2132')
    refute course.valid?, 'course is valid without name'
    assert_not_nil course.errors[:course_name],
                   'no validation error for course_name present'
  end
end
