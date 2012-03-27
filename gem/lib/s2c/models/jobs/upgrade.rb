module S2C
  module Models
    module Jobs
      class Upgrade < Base

        validates_presence_of :ticks_total
        validates_presence_of :ticks_remain

        def setup
          self.ticks_total  = S2C::Global.config["universe"]["upgrade_ticks"]
          self.ticks_remain = ticks_total
        end

        def step
          self.ticks_remain -= 1
          S2C::Global.logger.log( unit, "Upgrading, remains #{ticks_remain}" )
        end

        def finish?
          ticks_remain <= 0
        end

        def name
          "upgrade"
        end

      end
    end
  end
end