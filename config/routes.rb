Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: :json} do
   namespace :v1 do
     resources :sessions, only: [:create, :destroy]
     resources :registerations, only: [:create]
     resources :profiles do
        collection do
          patch :update_img
        end
     end
   end
  end
end
