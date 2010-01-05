ActionController::Routing::Routes.draw do |map|

  # Public Routes
  map.root :controller => "posts", :action => "index"

  map.resources :posts

  #map.connect ':controller/:action/:id'
  #map.connect ':controller/:action/:id.:format'
  
  # Needed for pingbacks
  map.connect ':controller/:action/:id.:format'
  
end
