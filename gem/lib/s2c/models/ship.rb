module S2C
  module Models
    class Ship < S2C::Models::Unit

      attr_accessor(
        :life,
        :velocity,
        :atack,
        :defense
      )

      def initialize( base )
        @id_prefix = "A"

        @life     = 10
        @fleet    = nil
        @velocity = 10
        @atack    = 10
        @defense  = 5

        super( base )
      end

    end
  end
end