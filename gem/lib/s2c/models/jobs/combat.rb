module S2C
  module Models
    module Jobs
      class Combat < Base

        belongs_to :target, :class_name => "S2C::Models::Units::Planet"
        validates_presence_of :target_id

        def step
          unit.ships.each do |ship|
            ship.hit( random_target_ship )
          end

          target.ships.each do |ship|
            ship.hit( random_unit_ship )
          end
        end

        def random_unit_ship
          S2C::Utils.get_random( unit.ships )
        end

        def random_target_ship
          S2C::Utils.get_random( target.ships )
        end

        def finish?
          target.ships.empty? || unit.ships.empty?
        end

        def name
          "combat"
        end

      end
    end
  end
end