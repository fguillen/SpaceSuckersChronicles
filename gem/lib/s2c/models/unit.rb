module S2C
  module Models
    class Unit
      ID_PREFIX = "U"

      attr_accessor(
        :id,
        :base,
        :job
      )

      def initialize( base )
        S2C::Global.logger.log( self, "Starting contruction Construction" )

        @id     ||= S2C::Global.store.next_id( ID_PREFIX )
        @base   ||= base
        @job    ||= nil
      end

      def work
        S2C::Global.logger.log( self, "Working" )

        @job.step if @job
      end
    end
  end
end