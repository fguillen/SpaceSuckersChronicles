module S2C
  module Models
    module Units
      class Ship < Base

        def setup
          super

          self.life     = S2C::Global.config["ship"]["life"]
          self.power    = S2C::Global.config["ship"]["power"]
          self.attack   = S2C::Global.config["ship"]["attack"]
          self.defense  = S2C::Global.config["ship"]["defense"]
        end

        def hit( target_ship )
          result = attack - target_ship.defense

          S2C::Global.logger.log( self, "Hit '#{target_ship.id}' with #{result} points" )

          if( result > 0 )
            target_ship.life -= result
            target_ship.save!
          end

          target_ship.base.remove_ship( target_ship ) if( target_ship.life <= 0 )
        end

        def name
          "ship"
        end

      end
    end
  end
end