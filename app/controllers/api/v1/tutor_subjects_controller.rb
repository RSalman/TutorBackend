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

      def all_subjects_request_status

        tutors_courses = Course.joins(tutor_subjects: :user)
                .select('courses.course_prefix, courses.course_code, tutor_subjects.id')
                .where('tutor_subjects.user_id = ' + params[:tutor_id])

        course_list = []
        course_subject_id = {} # Map of course -> Tutor subject ID

        tutors_courses.each do |course|
          courseCode = course.course_prefix + course.course_code
          course_list << courseCode
          course_subject_id[courseCode] = course.id
        end

        student_requests = PendingTutorRequest
                         .select('courses.course_prefix, courses.course_code')
                         .joins(tutor_subject: :course).where('tutor_id = ? AND student_id = ?',
                                                    params[:tutor_id], params[:student_id])

        courses_requested = []
        student_requests.each do |course|
          courses_requested << course.course_prefix + course.course_code
        end

        courses_request_status = []
        course_list.each do |course|

          temp = {}
          temp["course"] = course
          temp["isRequested"] = courses_requested.include? course
          temp["subjectID"] = course_subject_id[course]

          courses_request_status << temp
        end

        json_response(courses_request_status)
      end

      # Tutors cancel previous TutorSubjects by timestamping deleted_at
      def destroy
        TutorSubject.hide_subject(params[:id])
        head :ok
      end

      private

      def tutor_subject_params
        params.permit(:user_id, :course_id, :rate)
      end
    end
  end
end
