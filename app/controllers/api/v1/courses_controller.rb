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
        course = Course.create!(course_params)
        if course.valid?
          json_response(course, :created)
        else
          json_response(course.errors, :unprocessable_entity)
        end
      rescue
        head :conflict
      end

      def show
        course = Course.find(params[:id])
        json_response(course)
      end

      # Not for users
      def update
        course = Course.find(params[:id])
        course.update(course_params)
        if course.valid?
          json_response(course, :created)
        else
          json_response(course.errors, :unprocessable_entity)
        end
      rescue
        head :conflict
      end

      # Not for users
      def destroy
        Course.update(params[:id], hidden: nil)
        head :ok
      end

      private

      def course_params
        params.permit(:course_prefix, :course_code, :course_name)
      end
    end
  end
end
