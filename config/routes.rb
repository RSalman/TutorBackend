Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :tutor_infos, only: [:index, :create, :show, :update, :destroy]
    end
  end
end
