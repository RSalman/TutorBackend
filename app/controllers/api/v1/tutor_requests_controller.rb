# rubocop:disable Metrics/AbcSize
require_relative '../../../../lib/notifications'
module Api
  module V1
    # This defines the REST implementations for the controllers of the two tutor request models:
    # AcceptedTutorRequest and PendingTutorRequest. All requests for tutors and specific tutor subjects
    # are made from here.
    class TutorRequestsController < ApplicationController
      # Returns all accepted tutor requests given a tutor_id
      def accepted
        tutor_requests = AcceptedTutorRequest
                         .select('users.id AS user_id, users.first_name,
                                  users.last_name, users.agg_tutor_rating, users.num_tutor_rating,
                                  tutor_subjects.rate, users.phone_number, courses.course_prefix,
                                  courses.course_code, accepted_tutor_requests.id')
                         .joins(:tutor, tutor_subject: :course).where(tutor_id: params[:tutor_id])
        json_response(tutor_requests.all)
      end

      # Returns all pending tutor requests given a tutor_id
      def pending
        tutor_requests = PendingTutorRequest
                         .select('users.id AS user_id, users.first_name,
                                  users.last_name, users.agg_tutor_rating, users.num_tutor_rating,
                                  tutor_subjects.rate, users.phone_number, courses.course_prefix,
                                  courses.course_code, pending_tutor_requests.id')
                         .joins(:tutor, tutor_subject: :course).where(tutor_id: params[:tutor_id])
        json_response(tutor_requests.all)
      end

      # Requests a tutor given a tutor_subject_id, student_id and tutor_id
      def create
        # Change back after demo
        tutor_subject = TutorSubject.where(user_id: params[:tutor_id]).first
        pending_request = PendingTutorRequest.create(tutor_id: params[:tutor_id],
                                                     student_id: params[:student_id],
                                                     tutor_subject_id: tutor_subject.id)

        tutee = User.find(params[:student_id])
        # Look into see if there is another way to do this.
        course = Course.find(tutor_subject.course_id)

        course_code = course.course_prefix + course.course_code

        data = {
          course: course_code,
          tutee: tutee.first_name
        }

        notifcation_params = { 'user_id' => params[:tutor_id],
                               'title' => 'Request',
                               'body' => 'You have a new pending request for ' + course_code,
                               'icon' => 'request_new',
                               'color' =>  'lightgrey',
                               'type' =>   'request',
                               'associated_data' => data.to_json }

        if pending_request.valid?
          Notifications.send_notification(notifcation_params)
          json_response(pending_request, :created)
        else
          json_response(pending_request.errors, :unprocessable_entity)
        end
      end

      # Updates tutor request status from pending to accepted
      def update
        # TODO: add push notification here
        pending_request = PendingTutorRequest.find(params[:id])
        accepted_request = AcceptedTutorRequest
                           .create(pending_request.as_json(only: [:tutor_subject_id, :student_id, :tutor_id]))
        pending_request.destroy
        json_response(accepted_request, :ok)
      end

      # Removes a pending tutor request
      def cancel_request
        if params.key?(:tutor_id) && params.key?(:student_id) && params.key?(:subject_id)
          pending_request = PendingTutorRequest.where('tutor_id = ? AND student_id = ? AND tutor_subject_id = ?',
                                                      params[:tutor_id], params[:student_id], params[:subject_id]).first
          course = Course.find(TutorSubject.find(params[:subject_id]).course_id)
        else
          pending_request = PendingTutorRequest.find(params[:request_id])
          # Look into see if there is another way to do this.
          course = Course.find(TutorSubject.find(pending_request.tutor_subject_id).course_id)
        end

        pending_request.destroy
        course_code = course.course_prefix + course.course_code
        notifcation_params = { 'user_id' => params[:tutor_id],
                               'title' => 'Request Cencelled',
                               'body' => 'A request for ' + course_code + ' has been cancelled.',
                               'icon' => 'request_cancelled',
                               'color' =>  'lightgrey',
                               'type' =>   'cancel' }
        Notifications.send_notification(notifcation_params)

        head :ok
      end

      # Allows the student to rate the tutor
      def tutor_review
        AcceptedTutorRequest.where('tutor_rating IS NULL')
                            .where('id = ?', params[:id])
                            .update_all(tutor_rating: params[:tutor_rating])
        head :ok
      end

      # Allows the tutor to rate the student
      def student_review
        AcceptedTutorRequest.where('student_rating IS NULL')
                            .where('id = ?', params[:id])
                            .update(params[:id], student_rating: params[:student_rating])
        head :ok
      end

      private

      def tutor_request_params
        params.permit(:tutor_subject_id, :student_id, :tutor_id)
      end
    end
  end
end
