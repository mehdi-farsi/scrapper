class HomeController < ApplicationController
  def index
    @startups = Startup.includes(:founders, :social_networks).limit(200).all
  end
end
