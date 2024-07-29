Rails.application.routes.draw do
  devise_for :users

  root to: 'students#index'

  get 'students/:id/summary', to: 'students#summary', as: :student_summary
  get 'installments/:id/invoice', to: 'installments#invoice', as: :installment_invoice
  resources :installments
  resources :student_courses
  authenticate :user, lambda { |u| u.email.in?(['admin@g-tec.com']) } do
    mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  end
  resources :students
  resources :courses
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
