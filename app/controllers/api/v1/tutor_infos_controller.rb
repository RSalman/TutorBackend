# rubocop:disable Metrics/AbcSize
module Api
  module V1
    # REST endpoints for /tutor_info
    class TutorInfosController < ApplicationController
      # Lets the user create or update their tutor description (also sets their tutor_hidden flag to false)
      def update
        User.where(id: params[:id]).update_all(description: params[:description], tutor_hidden: false)
        head :ok
      end

      # Removes a user's tutor status by toggling tutor_hidden to true
      def destroy
        User.update_attribute(params[:id], :tutor_hidden, true)
        head :ok
      end

      # Get a Tutor's profile given tutor_id (user id)
      def index
        tutor = User.find(params[:tutor_id])

        courses = Course.joins(tutor_subjects: :user)
                        .select('courses.course_prefix, courses.course_code')
                        .where('tutor_subjects.user_id = ' + params[:tutor_id])

        course_list = []

        courses.each do |course|
          course_list << course.course_prefix + course.course_code
        end

        response = {
          biography: tutor.tutor_description,
          caption: tutor.tutor_short_description,
          firstname: tutor.first_name,
          lastname: tutor.last_name,
          degree: 'PhD, SEG', # until we find out where in DB... seperate table, multiple degrees?
          coursesTeaching: course_list
        }

        # if a student id and subject id are provided, return if a pending request already exists
        if params.key?(:student_id) && params.key?(:subject_id)
          response[:requestPending] = false
          pending_request = PendingTutorRequest.where('tutor_id = ? AND student_id = ? AND tutor_subject_id = ?',
                                                      params[:tutor_id], params[:student_id], params[:subject_id])
          response[:requestPending] = true unless pending_request.empty?
        end

        json_response(response)
      end
    end
  end
end
