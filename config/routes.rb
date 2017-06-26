Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'urls#index'
  get "/:short_url", to: "urls#show"
  get "shortened/:short_url", to: "urls#shortened", as: :shortened
  post "/urls/create"
  get "/urls/fetch_original_url"
end
