module S2C
  module Models
    class Construction
      attr_reader :id, :planet, :level, :type, :status, :process_tics
    
      # @@statuses = [
      #   :under_construction,
      #   :standby,
      #   :upgrading
      # ]
    
      def initialize( planet, type )
        @id = Time.now.to_i
        S2C::Universe.log( self, "Starting contruction Construction" )
        @planet = planet
        @level = 0
        @type = type
        @status = :under_construction
        @process_tics = self.upgrade_timing
        S2C::Universe.log( self, self.to_s )
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
        S2C::Universe.log( self, "Upgrading" )
      
        if( self.status != :standby )
          raise Exception, "can't upgrade a Construction in status: '#{self.status}'"
        end
      
        if( self.planet.black_stuff < self.upgrade_black_stuff )
          raise Exception, 'not enough black stuff'
        end
      
        self.planet.remove_black_stuff( self.upgrade_black_stuff )
        @status = :upgrading
        @process_tics = self.upgrade_timing
      end
    
      def work_under_construction
        S2C::Universe.log( self, "In contruction" )
      
        @process_tics -= 1
        if( @process_tics == 0 )
          S2C::Universe.log( self, "Built" )
          @level = 1
          @status = :standby
        end
      end
    
      def work_upgrading
        S2C::Universe.log( self, "Upgrading" )
      
        @process_tics -= 1
        if( @process_tics == 0 )
          @level += 1
          @status = :standby
          S2C::Universe.log( self, "Upgraded to level #{self.level}" )
        end
      end
    
      def work
        S2C::Universe.log( self, "Working" )
        self.send( "work_#{self.status}" )
      end
    
      def to_s
        "type:#{self.type} level:#{self.level} status:#{self.status} tics:#{self.process_tics}"
      end
    end
  end
end