module S2C
  module Models
    class Planet

      attr_accessor(
        :universe,
        :id,
        :units,
        :position
     )

      def initialize( position )
        S2C::Global.logger.log( self, "Creating planet" )

        @id        = S2C::Global.store.next_id( "X" )
        @units     = []
        @position  = position
      end

    end
  end
end