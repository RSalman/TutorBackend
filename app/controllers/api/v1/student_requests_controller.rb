module Api
  module V1
    # Controller for returning student-based requests
    class StudentRequestsController < ApplicationController
      # Returns all accepted student requests given a student_id
      def accepted
        student_requests = AcceptedTutorRequest
                           .select('users.id AS user_id, users.first_name,
                                  users.last_name, users.agg_tutor_rating, users.num_tutor_rating,
                                  tutor_subjects.rate, users.phone_number, courses.course_prefix,
                                  courses.course_code, accepted_tutor_requests.id')
                           .joins(:tutor, tutor_subject: :course).where(student_id: params[:student_id])
        json_response(student_requests.all)
      end

      # Returns all pending student requests given a student_id
      def pending
        student_requests = PendingTutorRequest
                           .select('users.id AS user_id, users.first_name,
                                  users.last_name, users.agg_tutor_rating, users.num_tutor_rating,
                                  tutor_subjects.rate, users.phone_number, courses.course_prefix,
                                  courses.course_code, pending_tutor_requests.id')
                           .joins(:tutor, tutor_subject: :course).where(student_id: params[:student_id])
        json_response(student_requests.all)
      end
    end
  end
end
