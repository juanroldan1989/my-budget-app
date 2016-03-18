Rails.application.routes.draw do
  get "/deals"          => "deals#index"
  get "/deals/single"   => "deals#single"
  get "/deals/combined" => "deals#combined"

  root "deals#index"
end
