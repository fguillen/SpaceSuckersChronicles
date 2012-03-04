module S2C
  module Models
    class Fleet < S2C::Models::Construction
      attr_reader(
        :traveling_to,
        :planet_destination
      )

      def initialize(planet, planet_destination, ships)
        planet.universe.log(self, "Sending Fleet from #{planet.identity} to #{planet_destination.identity}")
        super( planet, 'fleet' )
        travel( planet_destination )
      end

      def velocity
        property_value('velocity')
      end

      def attack
        property_value('attack')
      end

      def travel(planet_destiny)
        universe.log(self, "Traveling to #{planet_destiny.identity}")

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
          universe.log(self, "Has arrive to planet #{traveling_to.identity}")

          # FIXME: remove ships from planet
          planet.constructions.delete(self)
          traveling_to.constructions << selfs

          @planet = traveling_to
          @traveling_to = nil
          @status = :standby
        end
      end

      def stats
        result = ""
        result += "type:#{type}".ljust(20)
        result += "level:#{level}".ljust(20)
        result += "status:#{status}".ljust(20)

        if status == :travelig
          result += "destiny:#{traveling_to.identity}".ljust(20)
        end

        if status != :standby
          finish_time =
            remaining_ticks_to_time(
              process_remaining_ticks,
              universe.config['universe']['tick_seconds']
           )

          result += "remaining_ticks:#{process_remaining_ticks}".ljust(20)
          result += "time:#{finish_time.strftime('%Y-%m-%d %H:%M:%S')}"
        end

        result
      end

      def to_hash
        super.merge(
          :traveling_to => traveling_to ? traveling_to.name : nil
       )
      end

    end
  end
end