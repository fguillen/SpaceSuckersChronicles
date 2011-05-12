module S2C
  module Models
    class Mine < S2C::Models::Construction
    
      # @@statuses = 
      #   super.statuses + [
      #     :extracting
      #   ]
      
      def initialize( planet )
        S2C::Universe.log( self, "Starting construction mine" )
        super( planet, 'mine' )
      end

      def work_standby
        S2C::Universe.log( self, "Mine extracting" )
        self.planet.add_black_stuff( self.power )
      end
    end
  end
end