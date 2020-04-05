Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  devise_scope :user do
    authenticated do
      root to: "slots#index"
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: 'unauthenticated_path'
    end
  end

  # get 'bids/index'
  # get 'bids/show'
  # get 'bids/new'
  # get 'bids/edit'
  resources :slots do
    collection do
      get 'occupied'
      get 'free'
      get 'booked'
    end
    member do
      get 'confirm_booking'
      get 'approval'
      get 'rejection'
    end
  end

  resources :bids do
    member do
      get 'approval'
      get 'rejection'
    end
  end

end
