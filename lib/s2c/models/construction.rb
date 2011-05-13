module S2C
  module Models
    class Construction
      attr_reader :identity, :planet, :level, :type, :status, :process_tics, :universe
    
      # @@statuses = [
      #   :under_construction,
      #   :standby,
      #   :upgrading
      # ]
    
      def initialize( planet, type )
        @identity = Time.now.to_i + rand(1000)
        planet.universe.log( self, "Starting contruction Construction" )
        @universe = planet.universe
        @planet = planet
        @level = 0
        @type = type
        @status = :under_construction
        @process_tics = self.upgrade_timing
        self.universe.log( self, self.to_s )
      end
    
      # I know there are cleaner ways to define this methods 
      # but for the moment is ok.
      def attack
        self.property_value( 'attack' )
      end
    
      def defense
        self.property_value( 'defense' )
      end
    
      def power
        self.property_value( 'power' )
      end
    
      def upgrade_timing
        self.property_value( 'upgrade_timing' )
      end
    
      def upgrade_black_stuff
        self.property_value( 'upgrade_black_stuff' )
      end
    
      def upgrade_timing
        self.property_value( 'upgrade_timing' )
      end
    
      def property_value( property )
        init_value = S2C::Config.config[self.type][property]
        actual_value = init_value + ( init_value * ( @level * ( 1.1 ** @level ) ) ).round
      
        return actual_value
      end
    
      def upgrade
        self.universe.log( self, "Upgrading" )
      
        if( self.status != :standby )
          puts "ERROR: can't upgrade a Construction in status: '#{self.status}'"
          return false
        end
      
        if( self.planet.black_stuff < self.upgrade_black_stuff )
          puts "ERROR: not enough black stuff"
          return false
        end
      
        self.planet.remove_black_stuff( self.upgrade_black_stuff )
        @status = :upgrading
        @process_tics = self.upgrade_timing
      end
    
      def work_under_construction
        self.universe.log( self, "In contruction" )
      
        if( @process_tics == 0 )
          self.universe.log( self, "Built" )
          @level = 1
          @status = :standby
        end
        
        @process_tics -= 1
      end
    
      def work_upgrading
        self.universe.log( self, "Upgrading" )
      
        if( @process_tics == 0 )
          @level += 1
          @status = :standby
          self.universe.log( self, "Upgraded to level #{self.level}" )
        end
        
        @process_tics -= 1
      end
      
      def work_standby
        self.universe.log( self, "Standby" )
      end
    
      def work
        self.universe.log( self, "Working" )
        self.send( "work_#{self.status}" )
      end
    
      def stats
        result = ""
        result += "type:#{self.type}"
        result += " level:#{self.level}"
        result += " status:#{self.status}"
        
        if self.status != :standby
          result += " remain_tics:#{self.process_tics}"
          result += " ending_time:#{S2C::Utils.remaing_tics_to_time( self.process_tics ).strftime( '%Y-%m-%d %H:%M:%S' )}"
        end
        
        return result
      end
    end
  end
end