# frozen_string_literal: true
Rails.application.routes.draw do
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :tutor_infos, only: [:create, :update, :destroy]
      resources :courses, only: [:index, :create, :show, :update, :destroy]
      resources :tutor_subjects, only: [:index, :create]
      resources :tutor_requests, only: [:create, :update, :destroy]
      get :accepted_tutor_requests, to: 'tutor_requests#accepted'
      get :pending_tutor_requests, to: 'tutor_requests#pending'
      post :start_verify_phone, to: 'phone_verification#start'
      post :app_token, to: 'notifications#set_app_token'
    end
  end
end
