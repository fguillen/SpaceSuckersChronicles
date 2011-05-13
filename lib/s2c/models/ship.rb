module S2C
  module Models
    class Ship < S2C::Models::Construction
    
      # @@statuses = 
      #   super.statuses + [
      #     :traveling,
      #     :attacking
      #   ]
      
      def initialize( planet )
        planet.universe.log( self, "Starting construction ship" )
        @traveling_to = nil
        super( planet, 'ship' )
      end
      
      def velocity
        self.property_value( 'velocity' )
      end
      
      def travel( planet )
        self.universe.log( self, "Traveling to #{planet.identity}" )
        
        if( self.status != :standby )
          puts "ERROR: can't travel with a Ship in status: '#{self.status}'"
          return false
        end
      
        needed_black_stuff = S2C::Utils.travel_black_stuff( self.planet, planet )
        
        if( self.planet.black_stuff < needed_black_stuff )
          puts "ERROR: not enough black stuff"
          return false
        end
      
        self.planet.remove_black_stuff( needed_black_stuff )
        @status = :traveling
        @traveling_to = planet
        @process_tics = S2C::Utils.travel_time( self.planet, planet, self.velocity )
      end
      
      def work_traveling
        self.universe.log( self, "Traveling" )
      
        if( @process_tics == 0 )
          self.universe.log( self, "Has arrive to planet #{@traveling_to.identity}" )
          
          @traveling_to.constructions << @planet.constructions.delete( self )
          @planet = @traveling_to
          
          @traveling_to = nil
          @status = :standby
        end
        
        @process_tics -= 1
      end

      def stats
        result = ""
        result += "type:#{self.type}"
        result += " level:#{self.level}"
        result += " status:#{self.status}"

        if self.status == :travelig
          result += " destiny:#{@traveling_to}"
        end
        
        if self.status != :standby
          result += " remain_tics:#{self.process_tics}"
          result += " ending_time:#{S2C::Utils.remaing_tics_to_time( self.process_tics ).strftime( '%Y-%m-%d %H:%M:%S' )}"
        end
        
        return result
      end
    end
  end
end