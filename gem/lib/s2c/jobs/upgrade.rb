module S2C
  module Jobs
    class Upgrade < Base

      attr_accessor(
        :ticks_total,
        :ticks_remain
      )

      def initialize( opts )
        @unit         = opts[:unit]
        @callback     = opts[:callback]

        @ticks_total  = 10
        @ticks_remain = @ticks_total
      end

      def step
        @ticks_remain -= 1
        S2C::Global.logger.log( @unit, "Upgrading, remains #{@ticks_remain}" )
        @unit.send( @callback ) if finish?
      end

      def finish?
        @ticks_remain <= 0
      end

    end
  end
end