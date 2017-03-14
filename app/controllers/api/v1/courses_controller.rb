module Api
  module V1
    # REST endpoints for /courses
    class CoursesController < ApplicationController
      def index
        courses = Course.all
        json_response(courses)
      end

      # Not for users
      def create
        course = Course.create(course_params)
        # TODO: Add error-handling
        return unless course.valid?
        json_response(course, :created)
      end

      def show
        course = Course.find(params[:id])
        json_response(course)
      end

      # Not for users
      def update
        course = Course.find(params[:id])
        course.update(course_params)
        # TODO: Add error-handling
        return unless course.valid?
        head :no_content
      end

      # Not for users
      def destroy
        course = Course.find(params[:id])
        course.update_attribute(:hidden, true)
        head :no_content
      end

      private

      def course_params
        params.permit(:course_prefix, :course_code, :course_name)
      end
    end
  end
end
