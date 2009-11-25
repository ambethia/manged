ActionController::Routing::Routes.draw do |map|
  SprocketsApplication.routes(map)
  map.resources 'accounts'
  map.search '/search', :controller => 'search'
  map.root :controller => 'accounts'
end
