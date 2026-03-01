Rails.application.routes.draw do
  root to: "onboardings#new"
  resources :onboardings, param: :token, only: [:new, :create, :show, :update]

  get "up" => "rails/health#show", as: :rails_health_check
end
