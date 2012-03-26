module S2C
  module Models
    module Jobs
      class Combat < Base
        def step
          @unit.units.each do |unit|
            if finish?
              @unit.send( @callback )
              return
            end
            hit( unit, random_target_unit )
          end
        end

        def hit( unit, target_unit )
          result = unit.attack - target_unit.defense

          S2C::Global.logger.log( unit, "Hit '#{target_unit.id}' with #{result} points" )

          target_unit.life -= result                    if( result > 0 )
          S2C::Global.store.remove_ship( target_unit )  if( target_unit.life <= 0 )
        end

        def random_target_unit
          target_units = @targets.map{ |target| target.units }.flatten
          target_unit = S2C::Utils.get_random( target_units )

          target_unit
        end

        def finish?
          @targets.all? { |target| target.units.empty? }
        end

      end
    end
  end
end