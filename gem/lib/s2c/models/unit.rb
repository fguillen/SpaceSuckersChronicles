module S2C
  module Models
    class Unit

      attr_accessor(
        :id,
        :base,
        :job
      )

      def initialize( base )
        S2C::Global.logger.log( self, "Starting contruction Construction" )

        @id_prefix ||= "U"

        @id     ||= S2C::Global.store.next_id( @id_prefix )
        @base   ||= base
        @job    ||= nil
      end

      def work
        S2C::Global.logger.log( self, "Working" )

        self.job.step if self.job
      end
    end
  end
end