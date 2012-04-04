module S2C
  module Models
    module Units
      class Fleet < Base

        belongs_to :target, :class_name => "S2C::Models::Units::Planet"
        has_many :ships, :class_name => "S2C::Models::Units::Ship", :foreign_key => :base_id
        has_many :jobs, :class_name => "S2C::Models::Jobs::Base", :foreign_key => :unit_id

        validates_presence_of :target_id

        def self.arrange( opts )
          fleet =
            create!(
              :base   => opts[:base],
              :target => opts[:target]
            )

          opts[:ships].each do |ship|
            ship.update_attributes( :base => fleet )
            fleet.ships << ship
          end

          fleet
        end

        def start_trip
          S2C::Global.logger.event( :fleet, "**#{id}** start trip to **#{target.id}**")
          self.jobs <<
            S2C::Models::Jobs::Travel.create!(
              :unit     => self,
              :target   => target,
              :callback => :end_trip
            )
        end

        def end_trip
          S2C::Global.logger.log( self, "Arrived to planet #{target.id}" )

          if( target.ships.empty? )
            conquer_planet
          else
            start_combat
          end
        end

        def start_combat
          S2C::Global.logger.log( self, "Start combat against planet #{target.id}" )
          S2C::Global.logger.event( :fleet, "**#{id}** start combat against planet **#{target.id}**")

          self.jobs <<
            S2C::Models::Jobs::Combat.create!(
              :unit     => self,
              :target   => target,
              :callback => :end_combat
            )
        end

        def end_combat
          if( ships.empty? )
            surrender
          else
            conquer_planet
          end
        end

        def remove_ship( ship )
          ship.destroy
        end

        def surrender
          S2C::Global.logger.log( self, "Has been destroyed" )
          S2C::Global.logger.event( :fleet, "**#{id}** has been destroyed" )
          destroy
        end

        def conquer_planet
          S2C::Global.logger.log( self, "Planet conquered #{target.id}" )
          S2C::Global.logger.event( :planet, "**#{target.id}** has been conquered" )

          ships.each do |unit|
            unit.update_attributes( :base => target )
            target.ships.push( unit )
          end

          destroy
        end

        def name
          "fleet"
        end

      end
    end
  end
end