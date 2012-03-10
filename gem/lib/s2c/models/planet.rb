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

      def initialize(universe, opts = {})
        universe.log(self, "Creating planet")

        @black_stuff    = opts["black_stuff"] || universe.config["planet"]["initial_black_stuff"]
        @id             = opts["id"] || universe.generate_id( "X" )
        @constructions  = []
        @ships          = []
        @universe       = universe
        @position       = opts["position"]
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

      def combat( fleet )
        @status = :combat
        @combat_against = fleet

        ships.each { |e| e.combat( fleet, :type => :fleet ) }
      end

      def build_mine
        universe.log(self, "Building a mine")
        construction = S2C::Models::Mine.new(self)
        @constructions << construction
        @universe.units << contruction

        construction
      end

      def remove_ship( ship_id )
        @ships.delete_if { |e| e.id == ship_id }
        @constructions.delete_if { |e| e.id == ship_id }
      end

      def build_ship
        universe.log(self, "Building a ship")
        construction = S2C::Models::Ship.new(self)
        @constructions << construction
        @ships << construction
        @universe.units << construction

        construction
      end

      def build_fleet( traveling_to, ships )
        universe.log(self, "Building a fleet")

        ships do |ship|
          self.remove_ship( ship )
        end

        fleet = S2C::Models::Fleet.new(self)
        fleet.add_ships( ships )
        fleet.travel( traveling_to )

        @universe.units << fleet

        fleet
      end

      def to_hash
        constructions_hash = constructions.map { |e| e.to_hash }
        ship_ids = ships.map( &:id )

        {
          :black_stuff   => black_stuff,
          # :constructions => constructions_hash,
          :ship_ids      => ship_ids,
          :position      => position,
          :id            => id
        }
      end
    end
  end
end