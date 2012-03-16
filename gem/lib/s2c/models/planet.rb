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
        S2C::Utils.log( self, "Creating planet" )

        @id        = S2C::Utils.next_id( "X" )
        @units     = []
        @position  = position
      end

    end
  end
end