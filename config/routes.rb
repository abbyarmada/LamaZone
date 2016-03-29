# conditional_root = lambda {
#   category = Category.find_by_title('bestsellers') || nil
#   if category && category.books
#     '/home'
#   else
#     '/books'
#   end
# }

Rails.application.routes.draw do
  
  resources :checkouts
  
  # get 'static_pages/cart', path: 'cart'

  get 'static_pages/home', path: 'home'
  root to: 'static_pages#home'
  
  # if ActiveRecord::Base.connection.table_exists? 'categories'
  #   root :to => redirect(conditional_root.call)
  # end


  
  devise_for :customers, controllers: { omniauth_callbacks: "customers/omniauth_callbacks", 
    sessions: "customers/sessions", registrations: "customers/registrations" } 
  
  resources :customers, except: [:index, :destroy] do
    resources :ratings, only: :index
  end

  resources :addresses, except: [:index]

  # get 'customer/addresses', to: 'customers#addresses', as: :adresses
  
  devise_for :admins, controllers: { sessions: "admins/sessions" }
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  
  resources :credit_cards
  resources :countries

  post 'order_items/add_to_cart'
  post 'order_items/remove_from_cart'
  
  get 'order_items/index', path: 'checkout/cart'
  
  resources :order_items
  resources :orders
  resources :authors
  resources :categories
  
  resources :books, only: [:index, :show] do
    resources :ratings, shallow: true
    # collection do
    #   get 'books/bestsellers'
    # end
  end
end
