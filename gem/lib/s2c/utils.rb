module S2C
  module Utils

    extend self

    def save_universe( universe, path )
      File.open( path, "w" ) do |f|
        f.write JSON.pretty_generate( universe.to_hash )
      end
    end

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
      planet1 = universe.create_planet( [200,10] )
      planet2 = universe.create_planet( [50, 120] )
      planet3 = universe.create_planet( [150, 200] )
      planet4 = universe.create_planet( [300, 150] )
      planet5 = universe.create_planet( [400, 250] )
      planet6 = universe.create_planet( [500, 200] )
      planet7 = universe.create_planet( [450, 380] )
      planet8 = universe.create_planet( [100, 350] )
      planet9 = universe.create_planet( [260, 420] )
      planet10 = universe.create_planet( [30, 250] )
      planet11 = universe.create_planet( [430, 50] )

      3.times { planet1.build_ship }
      3.times { planet2.build_ship }
      3.times { planet3.build_ship }
      3.times { planet4.build_ship }
      3.times { planet5.build_ship }
      3.times { planet6.build_ship }
      3.times { planet7.build_ship }
      3.times { planet8.build_ship }

      universe
    end

  end
end