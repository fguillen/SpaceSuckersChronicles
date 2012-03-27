module S2C
  module Models
    module Jobs
      class BuildShip < Base

        validates_presence_of :ticks_total
        validates_presence_of :ticks_remain

        def setup
          self.ticks_total  = unit.production
          self.ticks_remain = unit.production
        end

        def step
          self.ticks_remain -= 1
          S2C::Global.logger.log( unit, "Building Ship, remains #{ticks_remain}" )
        end

        def finish?
          ticks_remain <= 0
        end

        def name
          "build_ship"
        end
      end
    end
  end
end