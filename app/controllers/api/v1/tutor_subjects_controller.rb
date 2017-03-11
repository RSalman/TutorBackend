module Api
  module V1
    # REST endpoints for /tutor_subjects
    class TutorSubjectsController < ApplicationController
      # GET /tutor_subjects
      def index
        tutor_subjects = TutorSubject.tutors_by_prefix_and_code(params[:q])
        json_response(tutor_subjects)
      end

      # POST /tutor_subjects
      def create
        tutor_subject = TutorSubject.create(tutor_subject_params)
        # TODO: Add error-handling
        return unless tutor_subject.valid?
        json_response(tutor_subject, :created)
      end

      private

      def tutor_subject_params
        params.permit(:tutor_info_id, :course_id, :rate, :deleted)
      end
    end
  end
end
