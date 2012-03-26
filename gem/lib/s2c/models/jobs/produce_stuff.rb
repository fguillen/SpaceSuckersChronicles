module S2C
  module Models
    module Jobs
      class ProduceStuff < Base
        def step
          S2C::Global.logger.log( unit, "Produccing #{@unit.production}" )
          @deposit.add_stuff( @unit.production )
        end
      end
    end
  end
end