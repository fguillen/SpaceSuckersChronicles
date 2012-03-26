module S2C
  module Models
    module Units
      class Mine < Base

        attr_accessor(
          :production,
          :level
        )

        def initialize( base )
          @id_prefix = "M"

          @production = 1
          @level      = 1

          super( base )
        end

        def start_produce
          @job =
            S2C::Models::Jobs::ProduceStuff.new(
              :unit     => self,
              :deposit  => base.silo
            )
        end

        def start_upgrade
          @job =
            S2C::Models::Jobs::Upgrade.new(
              :unit     => self,
              :callback => :end_upgrade
            )
        end

        def end_upgrade
          @job        = nil
          @level      += 1
          @production += 10

          start_produce
        end

      end
    end
  end
end