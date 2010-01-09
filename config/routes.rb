ActionController::Routing::Routes.draw do |map|

  # Public Routes
  map.root :controller => "posts", :action => "index"

  map.resources :posts, :has_many => :comments
  map.resources :categories

  map.archive_day 'archive/:year/:month/:day', :controller => 'posts', :action => 'archive'
  map.archive_month 'archive/:year/:month', :controller => 'posts', :action => 'archive'
  map.archive_year 'archive/:year', :controller => 'posts', :action => 'archive'

  # Admin Routes
  map.namespace(:admin) do |admin|
    admin.resources :posts
    admin.resources :categories
    admin.resources :comments
  end
  
  # Needed for pingbacks
  map.connect ':controller/:action/:id.:format'
  
end
