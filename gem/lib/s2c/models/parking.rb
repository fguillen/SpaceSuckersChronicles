module S2C
  module Models
    class Parking < S2C::Models::Unit

      attr_accessor(
        :capacity,
        :level
      )

      def initialize( base )
        @id_prefix = "P"

        @capacity   = 10
        @level      = 1

        super( base )
      end

      def start_upgrade
        @job =
          S2C::Jobs::Upgrade.new(
            :unit     => self,
            :callback => :end_upgrade
          )
      end

      def end_upgrade
        @job      = nil
        @level    += 1
        @capacity += 10
      end

      def add_ship
        S2C::Global.store.create_ship( self.base ) if !full?
      end

      def full?
        base.units.size >= capacity
      end

    end
  end
end