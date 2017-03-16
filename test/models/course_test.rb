require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  test 'valid course' do
    course = Course.create!(course_prefix: 'CSI', course_code: '2132', course_name: 'Database I')
    assert course.valid?
  end

  test 'invalid without prefix' do
    course = Course.create(course_code: '2132', course_name: 'Database I')
    refute course.valid?, 'course is valid without prefix'
    assert_not_empty course.errors[:course_prefix], 'no validation error for course_prefix present'
  end

  test 'invalid without code' do
    course = Course.create(course_prefix: 'CSI', course_name: 'Database I')
    refute course.valid?, 'course is valid without code'
    assert_not_empty course.errors[:course_code], 'no validation error for course_code present'
  end

  test 'invalid without name' do
    course = Course.create(course_prefix: 'CSI', course_code: '2132')
    refute course.valid?, 'course is valid without name'
    assert_not_empty course.errors[:course_name], 'no validation error for course_name present'
  end

  test 'invalid length too long' do
    course = Course.create(course_prefix: '12345678901', course_code: '2132')
    refute course.valid?, 'course is valid with prefix too long'
    assert_not_empty course.errors[:course_prefix], 'no validation error for course_prefix too long'
    course = Course.create(course_prefix: 'CSI', course_code: '12345678901')
    refute course.valid?, 'course is valid with code too long'
    assert_not_empty course.errors[:course_code], 'no validation error for course_code too long'
  end
end
