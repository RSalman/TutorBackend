module Api
  module V1
    # REST endpoints for /tutor_infos
    class TutorInfosController < ApplicationController
      # POST /tutor_infos
      def create
        tutor_info = TutorInfo.create!(tutor_info_params)
        json_response(tutor_info, :created)
      end

      # PUT /tutor_infos/:id
      def update
        tutor_info = TutorInfo.find(params[:id])
        tutor_info.update(tutor_info_params)
        head :no_content
      end

      # DELETE /tutor_infos/:id
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
