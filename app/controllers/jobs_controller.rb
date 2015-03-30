class JobsController < ApplicationController

  def show
    @job = Job.find_by!(id: params[:id], active: true)
    @people = Person.where(job_id: @job.id, active: true)
    @pics = Picture.where(job_id: @job.id, active: true).order(id: :desc).take(60)
  end

end
