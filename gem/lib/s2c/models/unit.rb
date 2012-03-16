module S2C
  module Models
    class Unit
      ID_PREFIX = "U"

      attr_reader(
        :id,
        :planet,
        :level,
        :job
      )

      def initialize(planet)
        S2C::Global.logger.log( self, "Starting contruction Construction" )

        @id     ||= S2C::Global.store.next_id( ID_PREFIX )
        @planet ||= planet
        @level  ||= 0
        @job    ||= nil
      end

      def work
        S2C::Global.logger.log( self, "Working" )

        @job.step if @job
      end
    end
  end
end