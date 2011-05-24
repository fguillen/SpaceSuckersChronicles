module S2C
  module Utils
    def self.remaining_ticks_to_time(remaining_ticks, tick_seconds)
      seconds = remaining_ticks * tick_seconds
      Time.now + seconds
    end
    
    def self.planet_distance(planet1, planet2)
      Math.sqrt(
        (planet2.position[0] - planet1.position[0]) ** 2 +
        (planet2.position[1] - planet1.position[1]) ** 2 
     ).round
    end
    
    def self.travel_consume_black_stuff(planet1, planet2, travel_black_stuff)
      distance = S2C::Utils.planet_distance(planet1, planet2)
      distance * travel_black_stuff
    end
    
    def self.travel_ticks(planet1, planet2, velocity)
      distance = S2C::Utils.planet_distance(planet1, planet2)
      (distance / velocity).round
    end
  end
end