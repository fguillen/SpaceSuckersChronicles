require 'benchmark'

module S2C
  class Store

    attr_reader :universe

    def initialize( universe )
      @universe = universe
      @last_id = 0
    end

    def next_id( prefix )
      @last_id += 1
      Kernel.sprintf( "#{prefix}%03d", @last_id )
    end

    def create_planet( position )
      planet = S2C::Models::Planet.new( position )
      @universe.planets << planet

      planet
    end

    def create_fleet( planet, destination, ships )
      fleet = S2C::Models::Fleet.new( planet, destination, ships )

      ships.each do |ship|
        ship.fleet = fleet
        planet.units.delete( ship )
      end

      fleet.start_trip

      @universe.units << fleet

      fleet
    end

    def remove_fleet( fleet )
      @universe.units.delete( fleet )
    end

    def create_ship( planet )
      ship = S2C::Models::Ship.new( planet )

      planet.units   << ship
      @universe.units << ship

      ship
    end

    def to_hash

    end
  end
end