class CatalogsController < ApplicationController

  def show
    @catalog = Catalog.find_by!(id: params[:id], active: true)
    @job = @catalog.person.job
    @person = @catalog.person
    @people = Person.where(job_id: @job.id, active: true)
    @pics = Picture.where(catalog_id: @catalog.id, active: true).order(id: :desc)
  end

end
