Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :show, :create, :destroy, :update]
      post :start_verify_phone, to: 'phone_verification#start'
      post :check_verify_phone, to: 'phone_verification#check'
    end
  end
end
