Rails.application.routes.draw do
  devise_for :users

  resources :users, :only => [] do
   resources :contacts
  end

  namespace :api ,defaults: { format: 'json' } do
    namespace :v1 do
     resources :users, :only => [] do
       resources :contacts, :only => [:index, :show]
     end
     
     resources :token_authentications, :only => [:create, :destroy]
    end
  end

  root :to => "home#index"
end
