module S2C
  module Models
    class Ship < S2C::Models::Unit

      attr_accessor(
        :fleet,
        :life,
        :velocity,
        :atack,
        :defense
      )

      def initialize( planet )
        @life     = 10
        @fleet    = nil
        @velocity = 10
        @atack    = 10
        @defense  = 5

        super( planet )
      end

    end
  end
end