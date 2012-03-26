module S2C
  module Models
    module Jobs
      class Upgrade < Base
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
end