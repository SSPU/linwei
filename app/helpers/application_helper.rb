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

  def current_info?(info)
    return false if !@info
    @info.id == info.id ? true : false
  end

  def first_info
    Infomation.first ? Infomation.first.id : 1;
  end

end
