module S2C
  module Models
    class Ship < S2C::Models::Construction
      attr_reader(
        :traveling_to,
        :in_fleet
      )

      attr_accessor :in_fleet

      def initialize(planet, opts = {} )
        @traveling_to = nil
        id = planet.universe.generate_id( "A" )
        opts = { "id" => id }.merge( opts )

        super( planet, 'ship', opts )
      end

      def velocity
        property_value('velocity')
      end

      def damage( points )
        @life -= points
        universe.log(self, "Damaged with #{points}, remains #{@life}")

        @status = :destroyed if @life <= 0

        @status
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

      def combat_reward
        universe.log(self, "Combat reward")
        @status = :standby
        @level += 1
      end

      def work_traveling
        universe.log(self, "Traveling")

        # if(@process_remaining_ticks == 0)
        #   universe.log(self, "Has arrive to planet #{traveling_to.id}")

        #   planet.units.delete(self)
        #   traveling_to.units << self

        #   @planet = traveling_to
        #   @traveling_to = nil
        #   @status = :standby
        # end
      end

      def work_combat
        universe.log( self, "Fighting against #{@combat_against.id}" )
        unit_against = S2C::Utils.get_random( @combat_against.units )

        if( unit_against.nil? )
          if( @combat_type == "fleet" )
            @planet.conquer( @combat_against )
          else
            @in_fleet.conquer( @combat_against )
          end

        elsif( hit( unit_against ) == :destroyed )
          if( @combat_against.destroy_unit( unit_against ) == :surrender )
            if( @combat_type == "fleet" )
              @planet.conquer( @combat_against )
            else
              @in_fleet.conquer( @combat_against )
            end
          end
        end
      end

      def hit( unit )
        universe.log( self, "Atacking #{unit.id}" )

        points_damage = attack - ( unit.defense / 2 )

        if( points_damage > 0 )
          universe.log( self, "Making a damage of #{points_damage}" )
          unit.damage( points_damage )
        else
          universe.log( self, "Atack failed against #{points_damage}" )
          :untouched
        end
      end

      def to_hash
        super.merge(
          :traveling_to => traveling_to ? traveling_to.id : nil
        )
      end

    end
  end
end