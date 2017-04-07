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
        if user.valid?
          # Clean all of this after demo
          courses = params[:courseList]
          courses.each do |course|
            /(?<prefix>[[:alpha:]]*)[[:space:]]*(?<code>[[:digit:]]*)/ =~ course
            next unless prefix && code
            course = Course.where(course_code: code, course_prefix: prefix).first
            if course.present?
              TutorSubject.create(user_id: user.id, course_id: course.id, rate: params[:rate])
            end
          end
          json_response(user, :created)
        else
          json_response(user.errors.full_messages, :unprocessable_entity)
        end
      rescue
        head :conflict
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
        params.permit(:first_name, :last_name, :email, :password, :phone_number, :image, :tutor_description)
      end

      def tutor_params
        params.permit(:courseList, :rate)
      end
    end
  end
end
