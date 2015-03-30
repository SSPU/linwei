class SitesController < ApplicationController

  def index
    @is_index = true
    @pics  = Picture.where(active: true).order(id: :desc).take(30)
    @pics_count = @pics.size
  end

end
