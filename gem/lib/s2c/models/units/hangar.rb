module S2C
  module Models
    module Units
      class Hangar < Base
        validates_presence_of :level
        validates_presence_of :base_id
        validates_presence_of :production
        validates_presence_of :building_ships

        def setup
          super

          self.building_ships = 0
          self.level          = 0
          self.production     = S2C::Global.config["hangar"]["production"]
        end

        def start_upgrade
          self.job =
            S2C::Models::Jobs::Upgrade.create!(
              :unit     => self,
              :callback => :end_upgrade
            )
        end

        def end_upgrade
          self.job.destroy
          self.level      += 1
          self.production /= 2

          self.save!
        end

        def build_ship
          self.building_ships += 1
          start_build_ship if job.nil?

          self.save!
        end

        def start_build_ship
          self.job =
            S2C::Models::Jobs::BuildShip.create(
              :unit     => self,
              :callback => :end_build_ship
            )
        end

        def end_build_ship
          self.job.destroy
          self.building_ships -= 1
          base.add_ship

          start_build_ship if( building_ships > 0 )
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

      end
    end
  end
end