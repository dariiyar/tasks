Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root 'application#render_404'
  resources :projects, only: [:index]

  get "*any", via: :all, to: 'application#render_404'
end
