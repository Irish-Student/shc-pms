Rails.application.routes.draw do

  # RESTful routes (CRUD- Ceate, Read, Update & Delete)
  # Nested route: putting stats (status's) resources in patients resources
  resources :patients do
    resources :stats
  end
  resources :appointments
 
  # paths
  get 'appointments/new'
  
  get 'patients/new'

  get 'sessions/new'

  get 'doctors/show'

  get 'doctors/new'

  get '/help', to:'static_pages#help'
  get '/about', to:'static_pages#about'
  get '/contact', to:'static_pages#contact'
  get '/signup', to: 'doctors#new'
  get '/login',   to: 'sessions#new'
  post'/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
  resources :doctors
  
end
