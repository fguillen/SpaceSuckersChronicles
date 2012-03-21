module S2C
  module Models
    class Mine < S2C::Models::Unit

      attr_accessor(
        :production,
        :level
      )

      def initialize( base )
        @id_prefix = "M"

        @production = 1
        @level      = 1

        super( base )
      end

      def start_produce
        @job =
          S2C::Jobs::ProduceStuff.new(
            :unit     => self,
            :deposit  => base.silo
          )
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

        start_produccing
      end

    end
  end
end