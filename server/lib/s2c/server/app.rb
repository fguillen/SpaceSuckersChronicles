module S2C::Server
  class App < Sinatra::Base
    # config      = S2C::Config.new("#{File.dirname(__FILE__)}/../../../config/config.yml")
    @@universe  = S2C::Global.universe
    # @@db_path   = File.expand_path( "#{File.dirname(__FILE__)}/../../../#{config["db"]}" )

    # if( File.exists?( @@db_path ) )
    #   hash = JSON.parse( File.read( @@db_path ) )
    #   @@universe.from_hash( hash )
    # else
    #   S2C::Utils.feed_universe( @@universe )
    # end

    S2C::Utils.feed_universe( @@universe )
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
      # S2C::Utils.save_universe( @@universe, @@db_path )

      S2C::JSONer.to_json( @@universe )
    end

    post "/fleets" do
      data = JSON.parse( request.body.read )

      planet = universe.get_planet( data["planet_id"] )
      planet_destination = universe.get_planet( data["traveling_to"] )
      ships = data["ship_ids"].map { |ship_id| universe.get_ship( ship_id ) }

      fleet = planet.build_fleet( planet_destination, ships )

      JSON.pretty_generate fleet.to_hash
    end

    def universe
      @@universe
    end
  end
end