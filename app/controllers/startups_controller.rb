class StartupsController < ApplicationController
  before_filter :set_startup, only: [:update]

  def update
    render nothing: true, status: :bad_request if !@startup.update_attributes(startup_params)
    render nothing: true, status: :ok
  end

private
  def set_startup
    @startup = Startup.find(params[:id])
  end

  def startup_params
    params.require(:startup).permit(:done, :uninteresting)
  end
end
