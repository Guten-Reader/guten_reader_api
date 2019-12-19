Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/downloads/:id', to: 'downloads#index'
      resources :users, only: [] do
        scope module: 'users' do
          resources :books, except: [:new, :edit]
        end
      end
    end
  end
end
