module S2C
  module Models
    module Units
      class Fleet < Base

        belongs_to :target, :class_name => "S2C::Models::Units::Planet"
        has_many :units, :class_name => "S2C::Models::Units::Ship", :foreign_key => :base_id

        validates_presence_of :target_id

        def self.arrange( opts )
          fleet =
            create(
              :base   => opts[:base],
              :target => opts[:target]
            )

          opts[:ships].each do |ship|
            ship.update_attributes( :base => fleet )
            fleet.units << ship
          end

          fleet
        end

        def start_trip
          self.job =
            S2C::Models::Jobs::Travel.create(
              :unit         => self,
              :callback     => :end_trip
            )
        end

        def end_trip
          S2C::Global.logger.log( self, "Arrived to planet #{destination.id}" )

          if( destination.units.empty? )
            conquer_planet
          else
            combat_planet
          end
        end

        def combat_planet
          S2C::Global.logger.log( self, "Start combat against planet #{destination.id}" )
          self.job =
            S2C::Models::Jobs::Combat.create(
              :unit     => self,
              :target   => target,
              :callback => :conquer_planet
            )

          target.job =
            S2C::Models::Jobs::Combat.create(
              :unit     => target,
              :target   => self,
              :callback => :after_battle
            )
        end

        def conquer_planet
          S2C::Global.logger.log( self, "Planet conquered #{destination.id}" )

          self.units.each do |units|
            unit.update_attributes( :base, destination )
            destination.units.push( unit )
          end

          self.destroy
        end

      end
    end
  end
end