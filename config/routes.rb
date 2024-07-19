Rails.application.routes.draw do
  resources :photos, only: [:index, :new, :create, :show]
  root "photos#index"
end
