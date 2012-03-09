module S2C::Server
  class App < Sinatra::Base
    config      = S2C::Config.new("#{File.dirname(__FILE__)}/../../../config/config.yml")
    @@universe  = S2C::Universe.new(config)
    @@universe.start

    S2C::Utils.feed_universe( @@universe )

    before do
      headers(
        'Access-Control-Allow-Origin'       => "*",
        'Access-Control-Allow-Methods'      => "POST, GET, OPTIONS, PUT, DELETE",
        'Access-Control-Allow-Headers'      => "*",
        'Access-Control-Max-Age'            => "1728000",
        'Access-Control-Allow-Headers'      => "Content-Type"
      )
    end

    get "/universe" do
      result = JSON.pretty_generate universe.to_hash
      puts "XXX: result: #{result}"
      result
    end

    post "/fleets" do
      data = JSON.parse( request.body.read )

      planet = universe.get_planet( data["planet_id"] )
      planet_destination = universe.get_planet( data["traveling_to"] )
      ships = data["ship_ids"].map { |ship_id| universe.get_ship( ship_id ) }

      fleet = planet.build_fleet( planet_destination, ships )

      data["ship_ids"].each do |ship_id|
        planet.remove_ship( ship_id )
      end

      JSON.pretty_generate fleet.to_hash
    end

    def universe
      @@universe
    end
  end
end