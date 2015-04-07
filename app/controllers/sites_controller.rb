class SitesController < ApplicationController

  def index
    @is_index = true
    index_job = Job.find_by index: true
    if index_job
      @pics  = Picture.where(active: true, job_id: index_job.id).order(id: :desc).take(30)
    else
      @pics  = Picture.where(active: true).order(id: :desc).take(30)
    end
    @pics_count = @pics.size
  end

end
