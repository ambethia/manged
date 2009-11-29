class SearchController < ApplicationController

  def index
    @query   = params[:q]
    @results = ThinkingSphinx.search @query, :page => params[:page], :per_page => 50
  end
end