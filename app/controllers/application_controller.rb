class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :get_jobs

  protected

  def get_jobs
    @title = "ESPTC"
    @jobs  = Job.where(active: true).order(position: :asc)
  end
end
