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
        user = User.create(user_params)
        # TODO: Add error-handling
        if user.valid?
          json_response(user, :created)
        else
          json_response(user.errors, :unprocessable_entity)
        end
      end

      def update
        user = User.find(params[:id])
        user.update(params[:user])
        # TODO: Add error-handling
        return unless user.valid?
        head :ok
      end

      def destroy
        User.destroy(params[:id])
        head :ok
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :phone_number)
      end
    end
  end
end
