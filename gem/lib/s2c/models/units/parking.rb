module S2C
  module Models
    module Units
      class Parking < Base

        validates_presence_of :base_id
        validates_presence_of :capacity
        validates_presence_of :level

        def setup
          super

          self.capacity = S2C::Global.config["parking"]["capacity"]
          self.level    = 0
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
          self.level    += 1
          self.capacity += 10

          self.save!
        end

        def full?
          base.ships.size >= capacity
        end

      end
    end
  end
end