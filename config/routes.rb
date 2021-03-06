Rails.application.routes.draw do

  devise_for :users, controllers: { sessions: 'users/sessions',
                                    registrations: 'users/registrations' }
  root 'pages#home'

  resources :secret_codes, except: [:new]

end
