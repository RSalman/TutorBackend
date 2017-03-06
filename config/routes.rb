Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :tutor_infos, only: [:create, :update, :destroy]
      resources :courses, only: [:index, :create, :show, :update, :destroy]
      resources :tutor_subjects, only: [:index, :create]
      post :start_verify_phone, to: 'phone_verification#start'
    end
  end
end
