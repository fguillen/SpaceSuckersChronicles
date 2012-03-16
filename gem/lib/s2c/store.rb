require 'benchmark'

module S2C
  class Store
    def initialize( universe )
      @universe
    end

    def self.create_planet( position )
      planet = S2C::Models::Planet.new( position )
      @universe.planets << planet

      planet
    end

    def self.create_fleet( planet, destination, ships )
      fleet = S2C::Models::Fleet.new( planet, destination, ships )

      ships.each do |ship|
        ship.fleet  = self
        planet.units.delete( ship )
      end

      fleet.start_trip

      @universe.units << fleet

      fleet
    end

    def self.create_ship( planet )
      ship = S2C::Models::Ship.new( planet )

      planet.units   << ship
      @universe.units << ship

      ship
    end
  end
end