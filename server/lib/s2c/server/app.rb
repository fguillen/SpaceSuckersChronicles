module S2C::Server
  class App < Sinatra::Base
    config      = S2C::Config.new("#{File.dirname(__FILE__)}/../../../config/config.yml")
    @@universe  = S2C::Universe.new(config)
    @@universe.start

    # show universe
    get "/universe" do
      JSON.pretty_generate universe.to_hash
    end

    # show planets
    get "/universe/planets" do
      JSON.pretty_generate universe.to_hash[:planets]
    end

    # show ships
    get "/universe/ships" do
      JSON.pretty_generate universe.to_hash[:ships]
    end

    # show planet
    get "/universe/planet/:name" do
      planet = universe.get_planet(params[:name])
      JSON.pretty_generate planet.to_hash
    end

    # create planet
    post "/universe/planet" do
      planet = universe.create_planet(params[:name])

      redirect_to_planet planet.name
    end

    # build mine
    post "/universe/planets/:name/mines" do
      planet = universe.get_planet(params[:name])
      planet.build_mine

      redirect_to_planet planet.name
    end

    # build ship
    post "/universe/planets/:name/ships" do
      planet = universe.get_planet(params[:name])
      planet.build_ship

      redirect_to_planet planet.name
    end

    # build fleet
    post "/universe/fleets" do
      params = JSON.parse( request.env["rack.input"].read )
      planet = universe.get_planet(params[:name])
      planet.build_fleet( params["planet_destination_id"], params["ship_ids"] )

      redirect_to_planet planet.name
    end

    # travel
    post "/universe/ships/:identity/travel" do
      ship   = universe.get_ship(params[:identity])
      planet = universe.get_planet(params[:planet_name])

      ship.travel(planet)

      redirect_to_planet ship.planet.name
    end

    def redirect_to_planet(name)
      redirect URI.escape("/universe/planet/#{name}")
    end

    def universe
      @@universe
    end
  end
end