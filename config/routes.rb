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

      resources :tutor_requests, only: [:create, :update, :destroy]
      get :accepted_tutor_requests, to: 'tutor_requests#accepted'
      get :pending_tutor_requests, to: 'tutor_requests#pending'
      post :start_verify_phone, to: 'phone_verification#start'
      post :app_token, to: 'notifications#set_app_token'
      post :generate_notification, to: 'notifications#generate_notification'
      post :tutor_review, to: 'tutor_requests#tutor_review'
      post :student_review, to: 'student_request#student_review'
      get :accepted_requests_info, to: 'tutor_requests#accepted_requests_info'
    end
  end
end
