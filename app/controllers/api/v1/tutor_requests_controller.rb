module Api
  module V1
    # REST endpoints for /tutor_requests
    class TutorRequestsController < ApplicationController
      # GET /accepted_tutor_requests
      def accepted
        tutor_requests = AcceptedTutorRequest.where(tutor_id: params[:tutor_id])
        json_response(tutor_requests.all)
      end

      # GET /pending_tutor_requests
      def pending
        tutor_requests = PendingTutorRequest.where(tutor_id: params[:tutor_id])
        json_response(tutor_requests)
      end

      # POST /tutor_requests
      def create
        pending_request = PendingTutorRequest.create(tutor_request_params)
        # TODO: add push notification here
        if pending_request.valid?
          json_response(pending_request, :created)
        else
          json_response(pending_request.errors, :unprocessable_entity)
        end
      end

      # PUT /tutor_requests
      def update
        # TODO: add push notification here
        PendingTutorRequest.destroy(params[:id])
        accepted_request = AcceptedTutorRequest.create(tutor_request_params)
        json_response(accepted_request, :ok)
      end

      # DELETE /tutor_requests
      def destroy
        pending_request = PendingTutorRequest.find(params[:id])
        pending_request.destroy
        head :no_content
      end

      private

      def tutor_request_params
        params.permit(:tutor_subject_id, :student_id, :tutor_id)
      end
    end
  end
end
