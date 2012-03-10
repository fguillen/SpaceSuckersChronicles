module S2C
  module Models
    class Ship < S2C::Models::Construction
      attr_reader(
        :traveling_to,
        :combat_against,
        :combat_type
      )

      def initialize(planet, opts = {} )
        @traveling_to = nil
        id = planet.universe.generate_id( "A" )
        opts = { "id" => id }.merge( opts )
        super( planet, 'ship', opts )
      end

      def velocity
        property_value('velocity')
      end

      def attack
        property_value('attack')
      end

      def combat( navy, opts )
        @status = :combat
        @combat_against = navy
        @combat_type = opts[:type]
      end


      def travel(planet_destiny)
        universe.log(self, "Traveling to #{planet.id}")

        if(status != :standby)
          universe.log(
            self,
            "ERROR: can't travel with a Ship in status: '#{status}'"
         )
          return false
        end

        needed_black_stuff =
          travel_consume_black_stuff(
            planet,
            planet_destiny,
            universe.config['universe']['travel_black_stuff']
         )

        if(planet.black_stuff < needed_black_stuff)
          universe.log(self, "ERROR: not enough black stuff")
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

          planet.constructions.delete(self)
          traveling_to.constructions << self

          @planet = traveling_to
          @traveling_to = nil
          @status = :standby
        end
      end

      def work_combat
        universe.log( self, "Fighting against #{combat_against.id}" )
      end

      def to_hash
        super.merge(
          :traveling_to => traveling_to ? traveling_to.id : nil
        )
      end

    end
  end
end