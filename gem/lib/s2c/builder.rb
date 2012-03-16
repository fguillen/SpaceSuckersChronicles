require 'benchmark'

module S2C
  module Builder
    def self.planet( universe, position )
      planet = S2C::Models::Planet.new( position )
      universe.planets << planet

      planet
    end

    def self.fleet( universe, planet, destination, ships )
      fleet = S2C::Models::Fleet.new( planet, destination, ships )
      fleet.start_trip

      universe.units << fleet

      fleet
    end

    def self.ship( universe, planet )
      ship = S2C::Models::Ship.new( planet )

      planet.units   << ship
      universe.units << ship

      ship
    end
  end
end