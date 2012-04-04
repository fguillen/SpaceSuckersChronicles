module S2C::Server
  class App < Sinatra::Base
    puts "XXX: S2C::VERSION: #{S2C::VERSION}"

    config_path = "#{File.dirname(__FILE__)}/../../../config/config.yml"
    S2C::Global.setup( config_path )

    @@universe  = S2C::Global.universe
    if @@universe.planets.empty?
      S2C::Utils.feed_universe( @@universe )
      @@universe.reload
    end
    # @@universe.start

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
      @@universe.step
      @@universe.reload
      result = S2C::JSONer.to_json( @@universe )
      puts result
      result
    end

    post "/fleets" do
      data = JSON.parse( request.body.read )

      puts "XXX: data: #{data}"

      base    = universe.planets.find( data["base_id"] )
      target  = universe.planets.find( data["destination_id"] )
      ships   = universe.ships.find( data["ship_ids"] )

      fleet =
        S2C::Models::Units::Fleet.arrange(
          :base   => base,
          :target => target,
          :ships  => ships
        )

      JSON.pretty_generate( S2C::JSONer.fleet_to_hash( fleet ) )
    end

    post "/upgrade/:id" do
      unit = universe.units.find( params[:id] )
      unit.start_upgrade

      "ok"
    end

    post "/build_ship/:hangar_id" do
      unit = universe.units.find( params[:hangar_id] )
      unit.start_build_ship

      "ok"
    end

    def universe
      @@universe
    end
  end
end