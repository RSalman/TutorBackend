require 'test_helper'

class TuteeReviewTest < ActiveSupport::TestCase
  def setup
    @course = Course.create(course_prefix: 'CSI', course_code: '2132',
                            course_name: 'Database I')
    @user = User.create(name: 'Test')
    @info = TutorInfo.new
    @user.tutor_info = @info
    @subject = @info.tutor_subjects.new(rate: 1, course_id: @course.id)
    @request = @subject.tutor_requests.new(user_id: @user.id)
  end

  test 'valid review' do
    review = TuteeReview.new(rating: 3)
    @request.tutee_review = review
    assert review.valid?
  end

  test 'invalid review rating' do
    review = TuteeReview.new
    @request.tutee_review = review
    refute review.valid?, 'review is valid without rating'
    assert_not_nil review.errors[:rating],
                   'no validation error for rating present'
  end

  test 'invalid review request' do
    review = TuteeReview.new(rating: 3)
    refute review.valid?, 'review is valid without request'
    assert_not_nil review.errors[:tutor_request_id],
                   'no validation error for request present'
  end
end
