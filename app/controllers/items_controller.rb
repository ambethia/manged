class ItemsController < ApplicationController
  make_resourceful { actions :all }

  private

  def current_objects
    @current_objects = current_model.paginate :page => params[:page], :per_page => 100,
      :order => "name ASC"
  end
end