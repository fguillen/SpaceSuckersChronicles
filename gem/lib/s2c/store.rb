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
      @universe.units << planet

      planet
    end

    def furnish_planet( planet )
      create_silo( planet )
      create_mine( planet )
      create_hangar( planet )
      create_parking( planet )
    end

    def create_silo( planet )
      silo = S2C::Models::Silo.new( planet )

      planet.silo = silo
      @universe.units << silo

      silo
    end

    def create_mine( planet )
      mine = S2C::Models::Mine.new( planet )

      planet.mine = mine
      @universe.units << mine

      mine
    end

    def create_parking( planet )
      parking = S2C::Models::Parking.new( planet )

      planet.parking = parking
      @universe.units << parking

      parking
    end

    def create_hangar( planet )
      hangar = S2C::Models::Hangar.new( planet )

      planet.hangar = hangar
      @universe.units << hangar

      hangar
    end

    def create_fleet( planet, destination, units )
      fleet = S2C::Models::Fleet.new( planet, destination, units )

      units.each do |unit|
        unit.base.units.delete( unit )
        unit.base = fleet
      end

      fleet.start_trip

      @universe.units << fleet

      fleet
    end

    def remove_fleet( fleet )
      S2C::Global.logger.log( fleet, "Removing..." )

      fleet.job = nil
      @universe.units.delete( fleet )
    end

    def remove_ship( ship )
      S2C::Global.logger.log( ship, "Removing..." )

      @universe.units.delete( ship )
      ship.base.units.delete( ship )

      if(
        ship.base.units.empty? &&
        ship.base.instance_of?( S2C::Models::Fleet )
      )
        remove_fleet( ship.base )
      end
    end

    def create_ship( base )
      ship = S2C::Models::Ship.new( base )

      base.units       << ship
      @universe.units  << ship

      ship
    end

    def reset
      @universe.units.clear
      @last_id = 0
    end

  end
end