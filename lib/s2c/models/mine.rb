module S2C
  module Models
    class Mine < S2C::Models::Construction
    
      # @@statuses = 
      #   super.statuses + [
      #     :extracting
      #   ]
      
      def initialize( planet )
        planet.universe.log( self, "Starting construction mine" )
        super( planet, 'mine' )
      end

      def work_standby
        self.universe.log( self, "Mine extracting" )
        self.planet.add_black_stuff( self.power )
      end
    end
  end
end