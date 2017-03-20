module Api
  module V1
    # REST endpoints for /tutor_subjects
    class TutorSubjectsController < ApplicationController
      # Allows users to query for TutorSubjects
      def index
        tutor_subjects = TutorSubject.tutors_by_prefix_and_code(params[:q], params[:last_id])
        json_response(tutor_subjects)
      end

      # Allows tutors to indicate which courses they can tutor and for how much
      def create
        tutor_subject = TutorSubject.create(tutor_subject_params)
        if tutor_subject.valid?
          json_response(tutor_subject, :created)
        else
          json_response(tutor_subject.errors, :unprocessable_entity)
        end
      end

      # Tutors cancel previous TutorSubjects by timestamping deleted_at
      def destroy
        sql = "UPDATE tutor_subjects SET deleted_at = CURRENT_TIMESTAMP WHERE deleted_at IS NULL AND id =
               #{ActiveRecord::Base.sanitize(params[:id])}"
        ActiveRecord::Base.connection.execute(sql)
        head :no_content
      end

      private

      def tutor_subject_params
        params.permit(:tutor_info_id, :course_id, :rate, :last_id)
      end
    end
  end
end
