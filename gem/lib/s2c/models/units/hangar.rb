module S2C
  module Models
    module Units
      class Hangar < Base
        validates_presence_of :level
        validates_presence_of :production
        validates_presence_of :building_ships

        def setup
          super

          self.building_ships = 0
          self.level          = 0
          self.production     = S2C::Global.config["hangar"]["production"]
        end

        def start_upgrade
          self.jobs <<
            S2C::Models::Jobs::Upgrade.create!(
              :unit     => self,
              :callback => :end_upgrade
            )
        end

        def end_upgrade
          S2C::Global.logger.log( self, "Upgraded" )

          self.level      += 1
          self.production /= 2

          self.save!
        end

        def start_build_ship
          self.jobs <<
            S2C::Models::Jobs::BuildShip.create!(
              :unit     => self,
              :callback => :end_build_ship
            )
        end

        def end_build_ship
          S2C::Global.logger.log( self, "Ship built" )
          base.add_ship
          remove_building_ships if base.parking.full?
        end

        def to_hash
          {
            :id             => id,
            :base_id        => base_id,
            :production     => production,
            :building_ships => building_ships
          }
        end

        def to_s
          to_hash.to_s
        end

        def building_ships
          jobs.count { |e| e.name == "build_ship" }
        end

        def remove_building_ships
          jobs.select { |e| e.name == "build_ship" }.each { |e| e.destroy }
        end

        def name
          "hangar"
        end

      end
    end
  end
end