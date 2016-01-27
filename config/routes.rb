Instapic::Application.routes.draw do
  root 'instaposts#index'
  resources :instaposts
end
