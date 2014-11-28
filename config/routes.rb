Rails.application.routes.draw do
  root to: 'articles#index'
  
  resources :articles do
    resources :comments   #this is defined as subresource
  end

  resources :tags
end
