class HomeController < ApplicationController
  def index
    @startups = Startup.includes(:founders, :social_networks).all
  end
end
