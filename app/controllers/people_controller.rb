class PeopleController < ApplicationController
  def show
    @person = Person.find_by!(id: params[:id], active: true)
    @job = @person.job
    @people = Person.where(job_id: @job.id, active: true)
    @pics = Picture.where(person_id: @person.id, active: true).order(id: :desc).take(60)
  end
end
