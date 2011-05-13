module S2C
  class Utils
    def self.remaing_tics_to_time( remain_tics )
      seconds = remain_tics * S2C::Config.config['universe']['tic_duration']
      return (Time.now + seconds)
    end
    
    def self.planet_distance( planet1, planet2 )
      result = ( Math.sqrt( ( planet2.position[0] - planet1.position[0] ) ** 2 + ( planet2.position[1] - planet1.position[1] ) ** 2 ) ).round
      
      puts "XXX: planet1: #{planet1.position.join('-')}"
      puts "XXX: planet2: #{planet2.position.join('-')}"
      puts "XXX: result: #{result}"
      
      return result
    end
    
    def self.travel_black_stuff( planet1, planet2 )
      distance = S2C::Utils.planet_distance( planet1, planet2 )
      black_stuff = distance * S2C::Config.config['universe']['travel_black_stuff']
      
      return black_stuff
    end
    
    def self.travel_time( planet1, planet2, velocity )
      distance = S2C::Utils.planet_distance( planet1, planet2 )
      tics = (distance / velocity).round
      
      return tics
    end
  end
end