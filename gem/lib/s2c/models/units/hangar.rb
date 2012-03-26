module S2C
  module Models
    module Units
      class Hangar < Base

        attr_accessor(
          :production_ticks,
          :level,
          :building_ships
        )

        def initialize( base )
          @id_prefix = "H"

          @production_ticks = 10
          @level            = 1
          @building_ships   = []

          super( base )
        end

        def job
          @job || building_ships.first
        end

        def start_upgrade
          @job =
            S2C::Models::Jobs::Upgrade.new(
              :unit     => self,
              :callback => :end_upgrade
            )
        end

        def end_upgrade
          @job              = nil
          @level            += 1
          @production_ticks /= 2
        end

        def build_ship
          job =
            S2C::Models::Jobs::BuildShip.new(
              :unit     => self,
              :callback => :ship_built
            )

          building_ships << job
        end

        def ship_built
          building_ships.delete_at( 0 )
          @base.parking.add_ship
        end

        def full?
          stuff >= capacity
        end

      end
    end
  end
end