module S2C
  module Models
    module Units
      class Planet < Base

        serialize :position

        has_one :mine,    :class_name => "S2C::Models::Units::Mine",    :foreign_key => "base_id"
        has_one :silo,    :class_name => "S2C::Models::Units::Silo",    :foreign_key => "base_id"
        has_one :hangar,  :class_name => "S2C::Models::Units::Hangar",  :foreign_key => "base_id"
        has_one :parking, :class_name => "S2C::Models::Units::Parking", :foreign_key => "base_id"

        def after_battle
          S2C::Global.logger.log( self, "Battle finished" )
          @job = nil
        end

      end
    end
  end
end