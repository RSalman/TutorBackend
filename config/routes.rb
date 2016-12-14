Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :users
    end
  end
end
