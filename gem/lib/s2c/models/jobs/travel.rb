module S2C
  module Models
    module Jobs
      class Travel < Base

        before_create :setup

        def step
          self.ticks_remain -= 1
          S2C::Global.logger.log( @unit, "Traveling to #{@destination.id} remains #{@ticks_remain}" )
          unit.send( callback.to_sym ) if finish?
        end

        def finish?
          ticks_remain <= 0
        end

        def setup
          self.ticks_total  =
            S2C::Utils.travel_ticks(
              unit.base,
              unit.destination,
              S2C::Global.config["fleet"]["velocity"]
            )

          self.ticks_remain = ticks_total
        end
      end
    end
  end
end