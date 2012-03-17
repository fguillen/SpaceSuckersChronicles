module S2C
  module Models
    class Fleet < S2C::Models::Unit

      attr_reader(
        :destination,
        :units
      )

      def initialize( planet, destination, units )
        @id_prefix = "F"

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

        if( @destination.units.empty? )
          conquer_planet
        else
          combat_planet
        end
      end

      def combat_planet
        S2C::Global.logger.log( self, "Start combat against planet #{destination.id}" )
        @job =
          S2C::Jobs::Combat.new(
            :unit     => self,
            :targets  => [@destination],
            :callback => :conquer_planet
          )

        @destination.job =
          S2C::Jobs::Combat.new(
            :unit     => @destination,
            :targets  => [self],
            :callback => :after_battle
          )
      end

      def conquer_planet
        S2C::Global.logger.log( self, "Planet conquered #{destination.id}" )
        @job = nil
        @destination.job = nil
        @destination.units.concat( self.units )
        S2C::Global.store.remove_fleet( self )
      end

      def velocity
        10
      end

    end
  end
end