module ApplicationHelper

  def current_job?(job)
    return false if !@job
    @job.id == job.id ? true : false
  end

  def current_person?(person)
    return false if !@person
    @person.id == person.id ? true : false
  end

  def current_catalog?(catalog)
    return false if !@catalog
    @catalog.id == catalog.id ? true : false
  end

end
