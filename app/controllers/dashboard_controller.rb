class DashboardController < ApplicationController

  def index
    @realm  = Realm.first
    @online = Character.online
  end
end