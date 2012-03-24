module S2C
  module Models
    class Ship < S2C::Models::Unit

      attr_accessor(
        :life,
        :power,
        :attack,
        :defense
      )

      def initialize( base )
        @id_prefix = "A"

        @life     = S2C::Global.config["ship"]["life"]
        @fleet    = nil
        @power    = S2C::Global.config["ship"]["power"]
        @attack    = S2C::Global.config["ship"]["attack"]
        @defense  = S2C::Global.config["ship"]["defense"]

        super( base )
      end

    end
  end
end