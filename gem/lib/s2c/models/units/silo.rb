module S2C
  module Models
    module Units
      class Silo < Base

        validates_presence_of :base_id
        validates_presence_of :capacity
        validates_presence_of :level

        def setup
          super

          self.capacity = S2C::Global.config["silo"]["capacity"]
          self.level    = 0
        end

        def start_upgrade
          self.jobs <<
            S2C::Models::Jobs::Upgrade.create!(
              :unit     => self,
              :callback => :end_upgrade
            )
        end

        def end_upgrade
          self.level    += 1
          self.capacity += 10

          self.save!
        end

        def name
          "silo"
        end

      end
    end
  end
end