module S2C
  module Jobs
    class Travel < Base

      attr_accessor(
        :ticks_total,
        :ticks_remain,
        :destination
      )

      def initialize( opts )
        @unit         = opts[:unit]
        @callback     = opts[:callback]
        @destination  = opts[:destination]

        @ticks_total  =
          S2C::Utils.travel_ticks(
            @unit.base,
            @destination,
            0.1
          )

        @ticks_remain = @ticks_total
      end

      def step
        @ticks_remain -= 1
        S2C::Global.logger.log( @unit, "Traveling to #{@destination.id} remains #{@ticks_remain}" )
        @unit.send( @callback ) if finish?
      end

      def finish?
        @ticks_remain <= 0
      end

    end
  end
end