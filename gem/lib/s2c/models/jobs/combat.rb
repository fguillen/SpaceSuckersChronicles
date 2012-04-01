module S2C
  module Models
    module Jobs
      class Combat < Base

        belongs_to :target, :class_name => "S2C::Models::Units::Planet"
        validates_presence_of :target_id

        def step
          unit.ships.each do |ship|
            target_ship = random_target_ship
            ship.hit( random_target_ship ) if target_ship
          end

          target.ships.each do |ship|
            unit_ship = random_unit_ship
            ship.hit( random_unit_ship ) if unit_ship
          end
        end

        def random_unit_ship
          S2C::Utils.get_random( unit.ships( true ) )
        end

        def random_target_ship
          S2C::Utils.get_random( target.ships( true ) )
        end

        def finish?
          target.ships.empty? || unit.ships.empty?
        end

        def name
          "combat"
        end

        def calculate_cost
          0
        end

      end
    end
  end
end