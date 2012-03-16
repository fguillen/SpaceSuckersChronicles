module S2C
  module Models
    class Planet
      ID_PREFIX = "X"

      attr_accessor(
        :id,
        :units,
        :position
      )

      def initialize( position )
        S2C::Global.logger.log( self, "Creating planet" )

        @id        = S2C::Global.store.next_id( ID_PREFIX )
        @units     = []
        @position  = position
      end

    end
  end
end