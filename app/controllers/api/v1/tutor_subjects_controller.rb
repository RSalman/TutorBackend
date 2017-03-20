module Api
  module V1
    # REST endpoints for /tutor_subjects
    class TutorSubjectsController < ApplicationController
      # Allows users to query for TutorSubjects
      def index
        tutor_subjects = TutorSubject.tutors_by_prefix_and_code(params[:q], params[:last_id])
        json_response(tutor_subjects)
      end

      # Allows tutors to indicate which courses they can tutor and for how much; deletes prior TutorSubjects prior to
      # creating the new one
      def create
        TutorSubject.hide_subject(params[:user_id], params[:course_id])
        tutor_subject = TutorSubject.create(tutor_subject_params)
        if tutor_subject.valid?
          json_response(tutor_subject, :created)
        else
          json_response(tutor_subject.errors, :unprocessable_entity)
        end
      end

      # Tutors cancel previous TutorSubjects by timestamping deleted_at
      def destroy
        TutorSubject.hide_subject(params[:id])
        head :ok
      end

      private

      def tutor_subject_params
        params.permit(:user_id, :course_id, :rate, :last_id)
      end
    end
  end
end
