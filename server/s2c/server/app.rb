require 'rubygems'
require 'sinatra/base'
require_relative '../../../gem/lib/s2c'

module S2C::Server
  class App < Sinatra::Base  
    config = S2C::Config.new
    @@universe = S2C::Universe.new(config)
    @@universe.start
    
    # show universe
    get "/universe" do
      universe.to_hash.to_json
    end
    
    # show planets
    get "/universe/planets" do
      universe.to_hash[:planets].to_json
    end
    
    # show ships
    get "/universe/ships" do
      universe.to_hash[:ships].to_json
    end

    # show planet
    get "/universe/planet/:name" do
      planet = universe.get_planet(params[:name])
      planet.to_hash.to_json
    end
    
    # create planet
    post "/universe/planet" do
      planet = universe.create_planet(params[:name])
      
      redirect "/universe/planet/#{planet.name}"
    end
    
    # build mine
    post "/universe/planets/:name/mines" do
      planet = universe.get_planet(params[:name])
      planet.build_mine
      
      redirect "/universe/planet/#{planet.name}"
    end
    
    # build ship
    post "/universe/planets/:name/ships" do
      planet = universe.get_planet(params[:name])
      planet.build_ship
      
      redirect "/universe/planet/#{planet.name}"
    end

    # travel
    post "/universe/ships/:identity/travel" do
      ship   = universe.get_ship(params[:identity])
      planet = universe.get_planet(params[:planet_name])

      ship.travel(planet)
      
      redirect "/universe/planet/#{ship.planet.name}"
    end
    
    def universe
      @@universe
    end
  end
end