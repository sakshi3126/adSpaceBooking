Rails.application.routes.draw do
  resources :slots do
    collection do
      get 'occupied'
      get 'free'
      get 'booked'
    end
  end
  devise_for :users, :controllers => {:registrations => "registrations"}

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
  root to: "slots#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
