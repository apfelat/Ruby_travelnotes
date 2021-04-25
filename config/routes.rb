Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
   collection do
     get "private_index", :to => "posts#private_index"
     get "private_index/edit", :to => "posts#edit"
     put "private_index", :to => "posts#update"
   end
 end
  root to: "home#index"
end