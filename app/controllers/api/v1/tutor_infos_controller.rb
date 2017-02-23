module Api
  module V1
    # REST endpoints for tutor info
    class TutorInfosController < ApplicationController
      # GET /tutor_infos
      def index
        tutor_infos = TutorInfo.all
        json_response(tutor_infos)
      end

      # POST /tutor_infos
      def create
        tutor_info = TutorInfo.create!(tutor_info_params)
        json_response(tutor_info, :created)
      end

      # GET /tutor_infos/:id
      def show
        tutor_info = TutorInfo.find(params[:id])
        json_response(tutor_info)
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
        # whitelist params
        params.permit(:title, :created_by)
      end
    end
  end
end
