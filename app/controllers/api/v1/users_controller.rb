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
        print params[:image]

        user = User.create(user_params)
        if user.valid?
          # Clean all of this after demo
          courses = params[:courseList]
          if courses
            courses.each do |course|
              /(?<prefix>[[:alpha:]]*)[[:space:]]*(?<code>[[:digit:]]*)/ =~ course
              next unless prefix and code
              course = Course.where(course_code: code, course_prefix: prefix).first
              if course.nil?
                course = Course.create(course_prefix: prefix, course_code: code, course_name: 'N/A')
              end
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
        user.update(user_params)

        old_courses_obj = Course.joins(tutor_subjects: :user)
                .select('courses.course_prefix, courses.course_code, tutor_subjects.id')
                .where('tutor_subjects.user_id = ' + params[:id])

        old_courses = []
        old_courses_obj.each do |course|
          old_courses << course.course_prefix + course.course_code
        end

        if user.valid?
          updated_courses = params[:courseList]
          if updated_courses
            courses_to_remove = old_courses - updated_courses
            courses_to_add = updated_courses - old_courses

            courses_to_remove.each do |course|
              /(?<prefix>[[:alpha:]]*)[[:space:]]*(?<code>[[:digit:]]*)/ =~ course
              next unless prefix and code
              course_to_remove = Course.where(course_code: code, course_prefix: prefix).first
              if course_to_remove
                TutorSubject.where(user_id: user.id, course_id: course_to_remove.id).first.destroy
              end
            end

            courses_to_add.each do |course|
              /(?<prefix>[[:alpha:]]*)[[:space:]]*(?<code>[[:digit:]]*)/ =~ course
              next unless prefix and code
              course_to_add = Course.where(course_code: code, course_prefix: prefix).first
              if course_to_add.nil?
                course_to_add = Course.create(course_prefix: prefix, course_code: code, course_name: 'N/A')
              end
              TutorSubject.create(user_id: user.id, course_id: course_to_add.id, rate: params[:rate])
            end
          end
        else
          json_response(user.errors.full_messages, :unprocessable_entity)
        end
        head :ok
      end      

      def destroy
        User.destroy(params[:id])
        head :ok
      end

      private

      def user_params
        params.permit(:first_name, :last_name, :email, :password, :phone_number, :image, :tutor_description, :education)
      end

      def tutor_params
        params.permit(:courseList, :rate)
      end
    end
  end
end