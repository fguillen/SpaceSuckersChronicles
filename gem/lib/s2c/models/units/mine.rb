module S2C
  module Models
    module Units
      class Mine < Base

        validates_presence_of :production
        validates_presence_of :level

        def setup
          super

          self.production = S2C::Global.config["mine"]["production"]
          self.level = 0
        end

        def start_produce
          jobs <<
            S2C::Models::Jobs::ProduceStuff.create!(
              :unit     => self,
              :callback => :produce
            )
        end

        def produce
          base.add_stuff production
        end

        def start_upgrade
          job.destroy if job

          jobs <<
            S2C::Models::Jobs::Upgrade.create!(
              :unit     => self,
              :callback => :end_upgrade
            )
        end

        def end_upgrade
          self.level      += 1
          self.production += 10

          save!

          start_produce
        end

        def name
          "mine"
        end

      end
    end
  end
end