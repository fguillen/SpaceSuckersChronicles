module S2C
  module Models
    class Silo < S2C::Models::Unit

      attr_accessor(
        :capacity,
        :stuff,
        :level
      )

      def initialize( base )
        @id_prefix = "S"

        @capacity = 10
        @stuff    = 0
        @level    = 1

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

      def add_stuff( stuff )
        self.stuff += stuff
        self.stuff = capacity if full?
      end

      def full?
        stuff >= capacity
      end

    end
  end
end