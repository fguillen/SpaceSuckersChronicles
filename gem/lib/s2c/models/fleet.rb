module S2C
  module Models
    class Fleet < S2C::Models::Unit
      ID_PREFIX = "F"

      attr_reader(
        :destination,
        :units
      )

      def initialize( planet, destination, units )
        @destination  = destination
        @units        = units

        super( planet )
      end

      def start_trip
        @job =
          S2C::Jobs::Travel.new(
            :unit         => self,
            :callback     => :end_trip,
            :destination  => @destination
          )
      end

      def end_trip
        S2C::Global.logger.log( self, "Arrived to planet #{destination.id}" )
        @job = nil
        @destination.units.concat( self.units )
        S2C::Global.store.remove_fleet( self )
      end

      def velocity
        10
      end

    end
  end
end