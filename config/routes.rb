Rails.application.routes.draw do
  root "home#index"

  devise_for :users, controllers: { omniauth_callbacks: "omniauth_callbacks" }

  resources :projects

  %w(404 422 500).each do |status_code|
    get status_code, to: "errors#show", code: status_code
  end
end
