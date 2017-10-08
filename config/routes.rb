Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users, only: [:index, :create, :show, :update, :destroy]

      # Allows users to create, edit, or delete their tutor profiles
      resources :tutor_infos, only: [:update, :destroy, :index]

      # Create, update, and destroy are not for user use
      resources :courses, only: [:index, :create, :show, :update, :destroy]

      # Allows tutors to indicate which subjects they can tutor
      resources :tutor_subjects, only: [:index, :create, :destroy]

      resources :tutor_requests, only: [:create, :update]
      get :accepted_student_requests, to: 'student_requests#accepted'
      get :pending_student_requests, to: 'student_requests#pending'
      get :accepted_tutor_requests, to: 'tutor_requests#accepted'
      get :pending_tutor_requests, to: 'tutor_requests#pending'
      get :all_subjects_request_status, to: 'tutor_subjects#all_subjects_request_status'
      post :cancel_tutor_request, to: 'tutor_requests#cancel_request'
      post :start_verify_phone, to: 'phone_verification#start'
      post :app_token, to: 'notifications#set_app_token'
      post :generate_notification, to: 'notifications#generate_notification'
      post :rate_student, to: 'tutor_requests#rate_student'
      post :rate_tutor, to: 'student_request#rate_tutor'
    end
  end
end
