class Startup < ActiveRecord::Base

  has_many :founders
  has_many :social_networks
end
