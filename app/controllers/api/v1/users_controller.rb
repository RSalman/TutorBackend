module Api
  module V1
    # REST endpoints for Users.
    class UsersController < ApplicationController
      respond_to :json

      def index
        respond_with User.all
      end

      def show
        user = User.select('*').left_joins(:tutor_info).find(params[:id])
        json_response(user)
      end

      def create
        respond_with User.create(params[:user])
      end

      def update
        respond_with User.update(params[:id], params[:user])
      end

      def destroy
        respond_with User.destroy(params[:id])
      end
    end
  end
end
