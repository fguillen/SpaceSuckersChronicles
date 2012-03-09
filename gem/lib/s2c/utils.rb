module S2C
  module Utils

    extend self

    def remaining_ticks_to_time(remaining_ticks, tick_seconds)
      seconds = remaining_ticks * tick_seconds
      Time.now + seconds
    end

    def planet_distance(planet1, planet2)
      Math.sqrt(
        (planet2.position[0] - planet1.position[0]) ** 2 +
        (planet2.position[1] - planet1.position[1]) ** 2
     ).round
    end

    def travel_consume_black_stuff(planet1, planet2, travel_black_stuff)
      distance = S2C::Utils.planet_distance(planet1, planet2)
      distance * travel_black_stuff
    end

    def travel_ticks(planet1, planet2, velocity)
      distance = S2C::Utils.planet_distance(planet1, planet2)
      (distance / velocity).round
    end

    def process_percent( process_total_ticks, process_remaining_ticks )
      return 100 if process_total_ticks == 0

      100 - ( ( 100 * process_remaining_ticks ) / process_total_ticks )
    end

    def feed_universe( universe )
      planet1 = universe.create_planet( 'X001', [10,10] )
      planet2 = universe.create_planet( 'X002', [20, 20] )
      planet3 = universe.create_planet( 'X003', [50, 200] )
      planet4 = universe.create_planet( 'X004', [300, 150] )
      planet5 = universe.create_planet( 'X005', [400, 250] )

      ship1 = planet1.build_ship
      ship2 = planet1.build_ship
      ship3 = planet1.build_ship

      ship4 = planet2.build_ship
      ship5 = planet2.build_ship

      ship6 = planet3.build_ship
      ship7 = planet3.build_ship
      ship8 = planet3.build_ship

      fleet1 = planet1.build_fleet( planet2, [ship1, ship2] )
      fleet2 = planet1.build_fleet( planet3, [ship3] )

      universe
    end

  end
end