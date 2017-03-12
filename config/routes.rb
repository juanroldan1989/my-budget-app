Rails.application.routes.draw do
  resources :deals, only: [:index, :show] do
    collection do
      get :filter
    end
  end

  resources :events, only: [] do
    collection do
      get :filter
    end
  end

  root "events#index"
end
