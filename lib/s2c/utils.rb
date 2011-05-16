module S2C
  class Utils
    def self.remaining_ticks_to_time( remaining_ticks )
      seconds = remaining_ticks * S2C::Config['universe']['tick_seconds']
      Time.now + seconds
    end
    
    def self.planet_distance( planet1, planet2 )
      Math.sqrt( ( planet2.position[0] - planet1.position[0] ) ** 2 + ( planet2.position[1] - planet1.position[1] ) ** 2 ).round
    end
    
    def self.travel_black_stuff( planet1, planet2 )
      distance = S2C::Utils.planet_distance( planet1, planet2 )
      distance * S2C::Config['universe']['travel_black_stuff']
    end
    
    def self.travel_ticks( planet1, planet2, velocity )
      distance = S2C::Utils.planet_distance( planet1, planet2 )
      ( distance / velocity ).round
    end
  end
end