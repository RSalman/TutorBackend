module Api
  module V1
    # REST endpoints for Users.
    class UsersController < ApplicationController
      def index
        users = User.all
        json_response(users)
      end

      def show
        user = User.select('*').left_joins(:tutor_info).find(params[:id])
        json_response(user)
      end

      def create
        user = User.create(params[:user])
        # TODO: Add error-handling
        return unless user.valid?
        json_response(user, :created)
      end

      def update
        user = User.find(params[:id])
        user.update(params[:user])
        # TODO: Add error-handling
        return unless user.valid?
        head :nocontent
      end

      def destroy
        User.destroy(params[:id])
        head :nocontent
      end
    end
  end
end
