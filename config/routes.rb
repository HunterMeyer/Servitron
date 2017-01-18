Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :screenshots, only: [:create, :show]
  end

  match '/queue' => DelayedJobWeb, anchor: false, via: [:get, :post]
end
