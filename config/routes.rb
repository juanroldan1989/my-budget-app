Rails.application.routes.draw do
  resources :deals, only: [:index]

  root "deals#index"
end
