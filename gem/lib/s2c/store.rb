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

    def move_units( units, destination )
      S2C::Global.logger.log( destination, "Moving #{units.size} units here" );

      units.each do |unit|
        unit.base.units.delete( unit )
        destination.units.push( unit )
        unit.base = destination
      end
    end

    def reset
      @universe.units.clear
    end

  end
end