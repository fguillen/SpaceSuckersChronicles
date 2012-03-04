module S2C
  module Models
    class Planet

      attr_reader(
        :universe,
        :black_stuff,
        :id,
        :constructions,
        :ships,
        :position
     )

      def initialize(universe, id, position)
        universe.log(self, "Creating planet")
        @black_stuff    = universe.config["planet"]["initial_black_stuff"]
        @id             = id
        @constructions  = []
        @ships          = []
        @universe       = universe
        @position       = position
      end

      def add_black_stuff(amount)
        universe.log(self, "Adding #{amount} black stuff to planet #{id}")
        @black_stuff += amount
      end

      def remove_black_stuff(amount)
        universe.log(
          self,
          "Removing #{amount} black stuff to planet #{id}"
        )

        @black_stuff -= amount
      end

      def build_mine
        universe.log(self, "Building a mine")
        construction = S2C::Models::Mine.new(self)
        @constructions << construction

        construction
      end

      def build_ship
        universe.log(self, "Building a ship")
        construction = S2C::Models::Ship.new(self)
        @constructions << construction
        @ships << construction

        construction
      end

      def build_fleet( planet_destination, ships )
        universe.log(self, "Building a fleet")
        construction = S2C::Models::Fleet.new(self, planet_destination, ships)
        @constructions << construction

        construction
      end

      def to_hash
        constructions_hash = constructions.map { |e| e.to_hash }
        ship_ids = ships.map( &:id )

        {
          :black_stuff   => black_stuff,
          :constructions => constructions_hash,
          :ship_ids      => ship_ids,
          :position      => position,
          :id            => id
        }
      end
    end
  end
end