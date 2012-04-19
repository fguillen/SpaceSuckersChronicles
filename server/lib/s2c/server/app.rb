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

    options "/*" do
      "*"
    end

    get "/universe" do
      @@universe.step
      @@universe.reload
      result = S2C::JSONer.to_json( @@universe )

      File.open( "#{File.dirname(__FILE__)}/../../../tmp/univers2_#{Time.now.to_i}.json", "w" ) { |f| f.write result }
      # puts result
      # result


      # File.open( "#{File.dirname(__FILE__)}/../../../tmp/universo.json", "w" ) { |f| f.write result }

      # File.read( "#{File.dirname(__FILE__)}/../../../tmp/universo.json" )

      result
    end

    post "/fleets" do
      data = JSON.parse( request.body.read )

      puts "XXX: data: #{data}"

      base    = universe.planets.find( data["base_id"] )
      target  = universe.planets.find( data["target_id"] )
      ships   = universe.ships.find( data["ship_ids"] )

      fleet =
        S2C::Models::Units::Fleet.arrange(
          :base   => base,
          :target => target,
          :ships  => ships
        )

      fleet.start_trip

      JSON.pretty_generate( S2C::JSONer.fleet_to_hash( fleet ) )
    end

    post "/upgrade/:id" do
      unit = universe.units.find( params[:id] )
      unit.start_upgrade

      { :result => "ok" }.to_json
    end

    post "/build_ship/:hangar_id" do
      unit = universe.units.find( params[:hangar_id] )
      unit.start_build_ship

      { :result => "ok" }.to_json
    end

    def universe
      @@universe
    end
  end
end