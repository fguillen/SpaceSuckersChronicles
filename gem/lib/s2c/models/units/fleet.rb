module S2C
  module Models
    module Units
      class Fleet < Base

        belongs_to :target, :class_name => "S2C::Models::Units::Planet"
        has_many :ships, :class_name => "S2C::Models::Units::Ship", :foreign_key => :base_id

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
          self.jobs <<
            S2C::Models::Jobs::Travel.create!(
              :unit     => self,
              :target   => self.target,
              :callback => :end_trip
            )
        end

        def end_trip
          S2C::Global.logger.log( self, "Arrived to planet #{target.id}" )

          if( target.ships.empty? )
            conquer_planet
          else
            combat_planet
          end
        end

        def start_combat
          S2C::Global.logger.log( self, "Start combat against planet #{target.id}" )

          self.job =
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

        def surrender
          S2C::Global.logger.log( self, "Has been destroyed" )
          destroy
        end

        def conquer_planet
          S2C::Global.logger.log( self, "Planet conquered #{target.id}" )

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