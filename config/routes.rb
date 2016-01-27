Instapic::Application.routes.draw do
  devise_for :users
  root 'instaposts#index'
  resources :instaposts
end
