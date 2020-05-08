Emailnet::Engine.routes.draw do
  resources :templates, only: [:index, :show, :update]
end
