Rails.application.routes.draw do
  get "/deals"          => "deals#index"
  get "/deals/filter"   => "deals#filter"
  get "/deals/:id"      => "deals#show"

  root "deals#index"
end
