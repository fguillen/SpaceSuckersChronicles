module S2C
  module Models
    class Silo < S2C::Models::Unit

      attr_accessor(
        :velocity,
        :level
      )

      def initialize( base )
        @id_prefix = "S"

        @velocity = 10
        @level    = 1

        super( base )
      end

      def start_upgrade
        @job =
          S2C::Jobs::Upgrade.new(
            :unit     => self,
            :callback => :end_upgrade
          )
      end

      def end_upgrade
        @job = nil
        @level += 1
      end

    end
  end
end