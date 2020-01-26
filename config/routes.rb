Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:show, :update] do
        scope module: 'users' do
          resources :books, except: [:new, :edit]
        end
      end
      resources :access_token, only: :show
    end
  end
end
