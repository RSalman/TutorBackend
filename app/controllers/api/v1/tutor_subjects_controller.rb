module Api
  module V1
    # REST endpoints for /tutor_subjects
    class TutorSubjectsController < ApplicationController
      # GET /tutor_subjects
      def index
        courses = Course.course_by_prefix_and_code(params[:course_prefix], params[:course_code])
        subjects = []
        courses.each do |course|
          current = TutorSubject.where(course_id: course.id)
          subjects.append(current) if current.any?
        end
        json_response(subjects)
      end

      # POST /tutor_subjects
      def create
        tutor_subject = TutorSubject.create!(tutor_subject_params)
        json_response(tutor_subject, :created)
      end

      # GET /tutor_subjects/:id
      def show
        tutor_subject = TutorSubject.find(params[:id])
        tutor_info = tutor_subject.tutor_info
        ret = { 'tutor_subject' => tutor_subject,
                'tutor_info' => tutor_info,
                'user' => tutor_info.user }
        json_response(ret)
      end

      private

      def tutor_subject_params
        params.permit(:tutor_info_id, :course_id, :rate, :deleted)
      end
    end
  end
end
