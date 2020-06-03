Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  root 'application#render_404'
  resources :projects, only: [:index, :create]

  resources :tasks, only: [:index] do
    collection do
      post :batch_create
    end
  end

  get "*any", via: :all, to: 'application#render_404'
end
