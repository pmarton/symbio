Symbio::Application.routes.draw do

  devise_for :users # user authentication

  match '/orders/toggle' # toggle orders (xhr)
  match '/bestellungen' => 'orders#index', :as => 'orders' 
  match '/rechnungen' => 'invoice_items#index', :as => 'invoice_items'
  match '/daily_order' => 'dashboard#daily_order'
  match '/preisliste' => 'pages#pricelist', :as => 'pricelist'

  namespace :admin do # admins only
    match 'orders/by_month', :as => :orders_by_month
    match 'users/top_up'
    resources :orders
    resources :invoice_items
    resources :menu_items do
      get :autocomplete_menu_item_name, :on => :collection
    end
    resources :meal_categories
    resources :users
  end
  
  root :to => 'dashboard#index' # front page
  match '*path' => 'dashboard#bad_route' # everything else
  
end
