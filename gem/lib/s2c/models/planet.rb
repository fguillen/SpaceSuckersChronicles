module S2C
  module Models
    class Planet < S2C::Models::Unit

      attr_accessor(
        :units,
        :position,
        :silo,
        :mine,
        :parking,
        :hangar
      )

      def initialize( position )
        S2C::Global.logger.log( self, "Creating planet" )

        @id_prefix = "X"

        @units     = []
        @position  = position
        @silo      = nil
        @mine      = nil
        @parking   = nil
        @hangar    = nil

        super( S2C::Global.universe )
      end

      def after_battle
        S2C::Global.logger.log( self, "Battle finished" )
        @job = nil
      end

    end
  end
end