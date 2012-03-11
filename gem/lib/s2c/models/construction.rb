module S2C
  module Models
    class Construction
      include S2C::Utils

      attr_reader(
        :id,
        :planet,
        :level,
        :type,
        :status,
        :process_remaining_ticks,
        :process_total_ticks,
        :universe,
        :life,
        :combat_against,
        :combat_type
      )

      def initialize(planet, type, opts = {})
        planet.universe.log(self, "Starting contruction Construction")

        @id                       = opts["id"] || (Time.now.to_i + rand(1000)).to_s
        @universe                 = planet.universe
        @planet                   = planet
        @level                    = opts["level"] || 0
        @type                     = opts["type"] || type
        @life                     = opts["level"] || universe.config[type]['life']
        @status                   = opts["status"] || :under_construction
        @process_total_ticks      = opts["process_total_ticks"] || upgrade_timing
        @process_remaining_ticks  = opts["process_remaining_ticks"] || process_total_ticks
        @combat_type              = opts["combat_type"]

        @combat_against = nil
        @combat_against = universe.get_fleet( opts["combat_against"] )  if combat_type == :fleet
        @combat_against = universe.get_planet( opts["combat_against"] ) if combat_type == :planet
      end

      def attack
        property_value('attack')
      end

      def defense
        property_value('defense')
      end

      def power
        property_value('power')
      end

      def upgrade_timing
        property_value('upgrade_timing')
      end

      def upgrade_black_stuff
        property_value('upgrade_black_stuff')
      end

      def upgrade_timing
        property_value('upgrade_timing')
      end

      def property_value(property)
        init_value = universe.config[type][property]
        init_value + (init_value * (@level * (1.1 ** @level))).round
      end

      def upgrade
        universe.log(self, "Upgrading")

        if(status != :standby)
          universe.log(
            self,
            "ERROR: can't upgrade a Construction in status: '#{status}'"
         )
          return false
        end

        if(planet.black_stuff < upgrade_black_stuff)
          universe.log(self, "ERROR: not enough black stuff")
          return false
        end

        planet.remove_black_stuff(upgrade_black_stuff)
        @status = :upgrading
        @process_remaining_ticks = upgrade_timing
      end

      def work
        universe.log(self, "Working")
        send("work_#{status}")
        @process_remaining_ticks -= 1
      end

      def work_under_construction
        universe.log(self, "In contruction")

        if(@process_remaining_ticks <= 0)
          universe.log(self, "Built")
          @level  = 1
          @status = :standby
        end
      end

      def work_upgrading
        universe.log(self, "Upgrading")

        if(@process_remaining_ticks == 0)
          @level += 1
          @status = :standby
          universe.log(self, "Upgraded to level #{level}")
        end
      end

      def work_standby
        universe.log(self, "Standby")
      end

      def to_hash
        {
          :id                       => id,
          :planet_id                => planet.id,
          :level                    => level,
          :type                     => type,
          :life                     => life,
          :status                   => status,
          :process_remaining_ticks  => process_remaining_ticks,
          :process_total_ticks      => process_total_ticks,
          :process_percent          => process_percent( process_total_ticks, process_remaining_ticks ),
          :combat_against           => combat_against ? combat_against.id : nil,
          :combat_type              => combat_type
        }
      end

    end
  end
end