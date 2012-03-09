module S2C
  module Models
    class Fleet < S2C::Models::Construction
      attr_reader(
        :traveling_to,
        :planet_destination,
        :ships
      )

      def initialize(planet, planet_destination, ships)
        planet.universe.log(self, "Sending Fleet from #{planet.id} to #{planet_destination.id}")

        super( planet, 'fleet' )

        @planet_destination = planet_destination
        @ships = ships

        travel( planet_destination )
      end

      def velocity
        property_value('velocity')
      end

      def attack
        property_value('attack')
      end

      def travel(planet_destiny)
        universe.log(self, "Traveling to #{planet_destiny.id}")

        needed_black_stuff =
          travel_consume_black_stuff(
            planet,
            planet_destiny,
            universe.config['universe']['travel_black_stuff']
         )

        if(planet.black_stuff < needed_black_stuff)
          universe.log(self, "ERROR: not enough black stuff. Needed '#{needed_black_stuff}', having '#{planet.black_stuff}'.")
          return false
        end

        planet.remove_black_stuff(needed_black_stuff)
        @status = :traveling
        @traveling_to = planet_destiny
        @process_total_ticks =
          travel_ticks(
            planet,
            planet_destiny,
            velocity
          )

        @process_remaining_ticks = process_total_ticks
      end

      def work_traveling
        universe.log(self, "Traveling")

        if(@process_remaining_ticks == 0)
          universe.log(self, "Has arrive to planet #{traveling_to.id}")

          # FIXME: remove ships from planet
          planet.constructions.delete(self)
          traveling_to.constructions.concat( self.ships )
          traveling_to.ships.concat( self.ships )

          self.remove
        end
      end

      def remove
        planet.constructions.delete(self)
      end

      def to_hash
        super.merge(
          :traveling_to => traveling_to ? traveling_to.id : nil,
          :ship_ids     => ships.map( &:id )
        )
      end

    end
  end
end