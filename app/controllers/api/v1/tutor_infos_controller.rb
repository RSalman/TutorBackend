module Api
  module V1
    # REST endpoints for /tutor_info
    class TutorInfoController < ApplicationController
      def create
        tutor_info = TutorInfo.create(tutor_info_params)
        # TODO: Add error-handling
        return unless tutor_info.valid?
        json_response(tutor_info, :created)
      end

      def update
        tutor_info = TutorInfo.find(params[:id])
        tutor_info.update(tutor_info_params)
        # TODO: Add error-handling
        return unless tutor_info.valid?
        head :no_content
      end

      def destroy
        tutor_info = TutorInfo.find(params[:id])
        tutor_info.destroy
        head :no_content
      end

      private

      def tutor_info_params
        params.permit(:description, :user_id)
      end
    end
  end
end
