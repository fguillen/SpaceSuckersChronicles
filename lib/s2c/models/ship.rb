module S2C
  module Models
    class Ship < S2C::Models::Construction
      attr_reader :traveling_to

      def initialize( planet )
        planet.universe.log( self, "Starting construction ship" )
        @traveling_to = nil
        super( planet, 'ship' )
      end
      
      def velocity
        property_value( 'velocity' )
      end

      def attack
        property_value( 'attack' )
      end
      
      def travel( planet_destiny )
        universe.log( self, "Traveling to #{planet.identity}" )
        
        if( status != :standby )
          universe.log( self, "ERROR: can't travel with a Ship in status: '#{status}'" )
          return false
        end
      
        needed_black_stuff = S2C::Utils.travel_black_stuff( planet, planet_destiny )
        
        if( planet.black_stuff < needed_black_stuff )
          universe.log( self, "ERROR: not enough black stuff" )
          return false
        end
      
        planet.remove_black_stuff( needed_black_stuff )
        @status = :traveling
        @traveling_to = planet_destiny
        @process_remaining_ticks = S2C::Utils.travel_ticks( planet, planet_destiny, velocity )
      end
      
      def work_traveling
        universe.log( self, "Traveling" )
      
        if( @process_remaining_ticks == 0 )
          universe.log( self, "Has arrive to planet #{traveling_to.identity}" )
          
          planet.constructions.delete( self )
          traveling_to.constructions << self
          
          @planet = traveling_to
          @traveling_to = nil
          @status = :standby
        end
      end

      def stats
        result = ""
        result += "type:#{type}".ljust( 20 )
        result += "level:#{level}".ljust( 20 )
        result += "status:#{status}".ljust( 20 )

        if status == :travelig
          result += "destiny:#{traveling_to.identity}".ljust( 20 )
        end
        
        if status != :standby
          result += "remaining_ticks:#{process_remaining_ticks}".ljust( 20 )
          result += "ending_time:#{S2C::Utils.remaining_ticks_to_time( process_remaining_ticks ).strftime( '%Y-%m-%d %H:%M:%S' )}"
        end
        
        result
      end
      
    end
  end
end