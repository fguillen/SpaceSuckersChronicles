module S2C
  module Models
    class Planet

      attr_reader(
        :universe,
        :black_stuff,
        :id,
        :units,
        :ships,
        :position
     )

      def initialize(universe, opts = {})
        universe.log(self, "Creating planet")

        @black_stuff    = opts["black_stuff"] || universe.config["planet"]["initial_black_stuff"]
        @id             = opts["id"] || universe.generate_id( "X" )
        @units  = []
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


      def conquer( navy )
        universe.log( self, "Navy conquered #{navy.id}" )
        navy.remove
        @ships.each { |e| e.combat_reward }
      end

      def destroy_unit( unit )
        @universe.log(self, "Destroying unit #{unit.id}")

        @units.delete( unit )
        @universe.units.delete( unit )

        if( @units.empty? )
          @universe.log(self, "Planet without units, surrender")
          return :surrender
        end

        return :still_combat
      end

      def build_mine
        universe.log(self, "Building a mine")
        construction = S2C::Models::Mine.new(self)
        @units << construction
        @universe.units << construction

        construction
      end

      def remove_ship( ship_id )
        @ships.delete_if { |e| e.id == ship_id }
        @units.delete_if { |e| e.id == ship_id }
      end

      def build_ship
        universe.log(self, "Building a ship")
        construction = S2C::Models::Ship.new(self)
        @units << construction
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
        units_hash = units.map { |e| e.to_hash }
        ship_ids = ships.map( &:id )

        {
          :black_stuff   => black_stuff,
          # :units => units_hash,
          :ship_ids      => ship_ids,
          :position      => position,
          :id            => id
        }
      end
    end
  end
end