module S2C
  module Models
    module Jobs
      class BuildShip < Base
        before_create :setup

        def step
          @ticks_remain -= 1
          S2C::Global.logger.log( @unit, "Building Ship, remains #{@ticks_remain}" )
          @unit.send( @callback ) if finish?
        end

        def finish?
          @ticks_remain <= 0
        end

        def setup
          self.ticks_total  = base.production_ticks
          self.ticks_remain = base.production_ticks
        end
      end
    end
  end
end