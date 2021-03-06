module S2C
  module Models
    module Jobs
      class ProduceStuff < Base

        def step
          S2C::Global.logger.log( unit, "Producing #{unit.production}" )
          unit.send( callback )
        end

        def finish?
          false
        end

        def name
          "produce_stuff"
        end

        def calculate_cost
          0
        end

      end
    end
  end
end