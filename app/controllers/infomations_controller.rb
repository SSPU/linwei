class InfomationsController < ApplicationController

  def show
    @is_info = true
    @infos = Infomation.where(active: true).order(position: :asc)
    @info = Infomation.find_by(id: params[:id], active: true)
  end

end
