module Api
  module V1
    # REST endpoints for /tutor_subjects
    class TutorSubjectsController < ApplicationController
      # GET /tutor_subjects
      def index
        courses = TutorSubject.tutors_by_prefix_and_code(params[:course_prefix], params[:course_code])
        json_response(courses)
      end

      # POST /tutor_subjects
      def create
        tutor_subject = TutorSubject.create!(tutor_subject_params)
        json_response(tutor_subject, :created)
      end

      private

      def tutor_subject_params
        params.permit(:tutor_info_id, :course_id, :rate, :deleted)
      end
    end
  end
end
