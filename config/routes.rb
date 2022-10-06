Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'dictionary', to: 'dictionary#index'
  post 'dictionary', to: 'dictionary#add'
  delete 'dictionary/:word', to: 'dictionary#remove'
  
  root :to => redirect('/dictionary')
end
