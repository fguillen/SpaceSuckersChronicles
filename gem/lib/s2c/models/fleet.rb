module S2C
  module Models
    class Fleet < S2C::Models::Unit

      attr_reader(
        :destination,
        :ships
      )

      def initialize( planet, destination, ships )
        @destination  = destination
        @ships        = ships

        super( planet )
      end

      def start_trip
        @ships.each do |ship|
          ship.fleet  = self
        end

        @job =
          S2C::Jobs::Travel.new(
            :unit         => self,
            :callback     => :end_trip,
            :destination  => @destination
          )
      end

      def end_trip
        S2C::Utils.log( self, "Arrived to planet #{destination.id}" )
        @job = nil
      end

      def velocity
        10
      end

    end
  end
end