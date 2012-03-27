module S2C
  module Models
    module Jobs
      class Travel < Base

        belongs_to :target, :class_name => "S2C::Models::Units::Planet"

        validates_presence_of :ticks_total
        validates_presence_of :ticks_remain
        validates_presence_of :target_id

        def setup
          self.ticks_total  =
            S2C::Utils.travel_ticks(
              unit.base,
              target,
              S2C::Global.config["fleet"]["velocity"]
            )

          self.ticks_remain = ticks_total
        end

        def step
          self.ticks_remain -= 1
          S2C::Global.logger.log( unit, "Traveling to #{target.id} remains #{ticks_remain}" )

          self.save!
        end

        def finish?
          ticks_remain <= 0
        end

        def name
          "travel"
        end
      end
    end
  end
end