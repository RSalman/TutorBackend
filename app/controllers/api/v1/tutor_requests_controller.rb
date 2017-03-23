module Api
  module V1
    # This defines the REST implementations for the controllers of the two tutor request models:
    # AcceptedTutorRequest and PendingTutorRequest. All requests for tutors and specific tutor subjects
    # are made from here.
    class TutorRequestsController < ApplicationController
      # Returns all accepted tutor requests given a tutor_id
      def accepted
        tutor_requests = AcceptedTutorRequest.where(tutor_id: params[:tutor_id])
        json_response(tutor_requests.all)
      end

      # Returns all pending tutor requests given a tutor_id
      def pending
        tutor_requests = PendingTutorRequest.where(tutor_id: params[:tutor_id])
        json_response(tutor_requests)
      end

      # Requests a tutor given a tutor_subject_id, student_id and tutor_id
      def create
        pending_request = PendingTutorRequest.create(tutor_request_params)
        # TODO: add push notification here
        if pending_request.valid?
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
      def destroy
        pending_request = PendingTutorRequest.destroy(params[:id])
        # TODO: add push notification here
        pending_request.destroy
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
