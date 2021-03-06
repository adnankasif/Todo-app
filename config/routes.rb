Rails.application.routes.draw do
  get '/home' => 'dashboard#home'
  get '/project_manager_dashboard' => 'dashboard#project_manager_dashboard'
  get '/developer_dashboard' => 'dashboard#developer_dashboard'

  root to: 'dashboard#home'

  devise_for :users

  devise_scope :user do
    get 'sign_in', to: 'devise/sessions#new'
    get 'log_in', to: 'devise/sessions#new'
    delete 'log_out', to: 'devise/sessions#destroy'
  end

  post '/dashboard/create_project' => 'dashboard#create_project'
  get  '/dashboard/get_developers' => 'dashboard#get_available_developers'
  post '/dashboard/save_project' => 'dashboard#save_project'
  post '/dashboard/save_todo_for_project' => 'dashboard#save_todo'
  post '/dashboard/assign_todo_dev' => 'dashboard#assign_todo_dev'
  get '/dashboard/get_todo_status' => 'dashboard#get_todo_status'
  post '/dashboard/change_todo_status' => 'dashboard#change_todo_status'
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
