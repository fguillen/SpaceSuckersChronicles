module S2C
  module Jobs
    class ProduceStuff < Base

      attr_accessor(
        :deposit
      )

      def initialize( opts )
        @unit         = opts[:unit]
        @deposit      = opts[:deposit]
      end

      def step
        S2C::Global.logger.log( unit, "Produccing #{@unit.production}" )
        @deposit.add_stuff( @unit.production )
      end

    end
  end
end