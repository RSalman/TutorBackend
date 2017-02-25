module Api
  module V1
    # REST endpoints for /courses
    class CoursesController < ApplicationController
      # GET /courses
      def index
        courses = Course.all
        json_response(courses)
      end

      # POST /courses
      def create
        course = Course.create!(course_params)
        json_response(course, :created)
      end

      # GET /courses/:id
      def show
        course = Course.find(params[:id])
        json_response(course)
      end

      # PUT /courses/:id
      def update
        course = Course.find(params[:id])
        course.update(course_params)
        head :no_content
      end

      # DELETE /courses/:id
      def destroy
        Course.destroy(params[:id])
        head :no_content
      end

      private

      def course_params
        params.permit(:course_prefix, :course_code, :course_name)
      end
    end
  end
end
