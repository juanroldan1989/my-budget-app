Rails.application.routes.draw do
  # WIP
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

  get "*a" => redirect("/")
end
