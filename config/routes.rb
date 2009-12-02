ActionController::Routing::Routes.draw do |map|
  SprocketsApplication.routes(map)
  map.resources 'accounts'
  map.resources 'items'
  map.search 'search', :controller => 'search'
  map.dashboard '', :controller => 'dashboard'
  map.root :controller => 'dashboard'
end
