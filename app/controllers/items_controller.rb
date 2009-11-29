class ItemsController < ApplicationController
  make_resourceful { actions :all }

  private

  def build_object
    if params[:copy] && copy = Item.find_by_entry(params[:copy])
      @current_object = copy.clone
    else
      @current_object = Item.new
    end
  end

  def current_objects
    @current_objects = current_model.paginate :page => params[:page], :per_page => 100,
      :order => "entry DESC"
  end
end