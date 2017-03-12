require 'test_helper'

class TutorReviewTest < ActiveSupport::TestCase
  def setup
    @course = Course.create(course_prefix: 'CSI', course_code: '2132',
                            course_name: 'Database I')
    @user = User.new(first_name: 'best', last_name: 'test', email: 'test@uottawa.ca', password: 'supersecurePassword',
                     phone_number: '6135223652')
    @info = TutorInfo.new
    @user.tutor_info = @info
    @subject = @info.tutor_subjects.new(rate: 1, course_id: @course.id)
    @request = @subject.tutor_requests.new(user_id: @user.id)
  end

  test 'valid review' do
    review = TutorReview.new(rating: 3)
    @request.tutor_review = review
    assert review.valid?
  end

  test 'invalid review rating' do
    review = TutorReview.new
    @request.tutor_review = review
    refute review.valid?, 'review is valid without rating'
    assert_not_nil review.errors[:rating],
                   'no validation error for rating present'
  end

  test 'invalid review request' do
    review = TutorReview.new(rating: 3)
    refute review.valid?, 'review is valid without request'
    assert_not_nil review.errors[:tutor_request_id],
                   'no validation error for request present'
  end
end
