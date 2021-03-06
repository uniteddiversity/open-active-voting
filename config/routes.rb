OpenActiveVoting::Application.routes.draw do
  get "votes/authentication_options"
  post "votes/authenticate_from_island_is"

  get "votes/ballot"
  get "votes/get_ballot"
  post "votes/post_vote"
  get "votes/logout_and_information"
  get "votes/logout"
  get "votes/select_area"
  get "votes/help_info"
  get "votes/about_info"
  get "votes/rules_info"
  get "votes/idea_info"
  get "votes/government_info"
  get "votes/areas_info"
  get "votes/ibuar_info"
  get "votes/rvk_info"
  get "votes/logout_info"
  get "votes/force_session_id"
  get "votes/lukr_map"
  get "votes/lukr_map_2"

  root :to => 'votes#check_authentication'

  # The idea is based upon order of creation:
  # first created -> highest idea.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
