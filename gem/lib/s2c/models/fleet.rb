module S2C
  module Models
    class Fleet < S2C::Models::Construction
      attr_reader(
        :traveling_to,
        :ships,
        :combat_against
      )

      def initialize( planet, opts = {} )
        @ships = []

        @traveling_to = planet.universe.get_planet( opts["traveling_to"] ) if opts["traveling_to"]
        id = planet.universe.generate_id( "F" )
        opts = { "status" => :standby, "id" => id }.merge( opts )
        super( planet, 'fleet', opts )
      end

      def add_ships( ships )
        @ships.concat( ships )
      end

      def velocity
        property_value('velocity')
      end

      def attack
        property_value('attack')
      end

      def travel(traveling_to)
        universe.log(self, "Traveling to #{traveling_to.id}")

        needed_black_stuff =
          travel_consume_black_stuff(
            planet,
            traveling_to,
            universe.config['universe']['travel_black_stuff']
         )

        if(planet.black_stuff < needed_black_stuff)
          universe.log(self, "ERROR: not enough black stuff. Needed '#{needed_black_stuff}', having '#{planet.black_stuff}'.")
          # return false
        end

        planet.remove_black_stuff(needed_black_stuff)
        @status = :traveling
        @traveling_to = traveling_to
        @process_total_ticks =
          travel_ticks(
            planet,
            traveling_to,
            velocity
          )

        @process_remaining_ticks = process_total_ticks
      end

      def work_traveling
        universe.log( self, "Traveling to #{traveling_to.id} remains #{process_remaining_ticks}" )

        if(@process_remaining_ticks == 0)
          universe.log(self, "Has arrived to planet #{traveling_to.id}")

          combat( traveling_to )
        end
      end


      def work_combat
        universe.log( self, "Fighting against #{combat_against.id}" )



      end

      def combat( planet )
        planet.combat( self )

        @status = :combat
        @combat_against = planet

        ships.each { |e| e.combat( planet, :type => :planet ) }
      end

      def remove
        planet.constructions.delete(self)
      end

      def to_hash
        puts "XXX: fleet: #{id} traveling to: '#{traveling_to}'"
        super.merge(
          :traveling_to => traveling_to ? traveling_to.id : nil,
          :ship_ids     => ships.map( &:id )
        )
      end

    end
  end
end