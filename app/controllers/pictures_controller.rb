class PicturesController < ApplicationController

  def show
    @picture = Picture.find_by!(id: params[:id], active: true)
    @catalog = @picture.catalog
    @job = @catalog.person.job
    @person = @catalog.person
    @people = Person.where(job_id: @job.id, active: true)
  end

end
