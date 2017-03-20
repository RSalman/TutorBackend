module Api
  module V1
    # REST endpoints for /tutor_info
    class TutorInfoController < ApplicationController
      # Lets the user create or update their tutor description (also sets their tutor_hidden flag to false)
      def update
        User.where(id: params[:id]).update_all(description: params[:description], tutor_hidden: false)
        head :no_content
      end

      # Removes a user's tutor status by toggling tutor_hidden to true
      def destroy
        User.update_attribute(params[:id], :tutor_hidden, true)
        head :no_content
      end
    end
  end
end
