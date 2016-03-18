Rails.application.routes.draw do
  get "/deals"          => "deals#index"
  get "/deals/single"   => "deals#single"
  get "/deals/combined" => "deals#combined"
  get "/deals/:id"      => "deals#show"

  root "deals#index"
end
