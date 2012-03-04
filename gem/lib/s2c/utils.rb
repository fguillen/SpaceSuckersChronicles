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

  end
end