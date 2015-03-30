class JobsController < ApplicationController

  def show
    @job = Job.find params[:id]
    @people = Person.where(job_id: @job.id, active: true)
    @pics = Picture.where(job_id: @job.id, active: true).order(id: :desc).take(60)
  end

end
