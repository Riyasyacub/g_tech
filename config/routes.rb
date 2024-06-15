Rails.application.routes.draw do
  root 'students#index'
  get 'installments/:id/invoice', to: 'installments#invoice', as: :installment_invoice
  resources :installments
  resources :student_courses
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :students
  resources :courses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
