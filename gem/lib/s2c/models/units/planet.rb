module S2C
  module Models
    module Units
      class Planet < Base

        serialize :position

        has_many :ships,  :class_name => "S2C::Models::Units::Ship",    :foreign_key => "base_id"

        has_one :mine,    :class_name => "S2C::Models::Units::Mine",    :foreign_key => "base_id"
        has_one :silo,    :class_name => "S2C::Models::Units::Silo",    :foreign_key => "base_id"
        has_one :hangar,  :class_name => "S2C::Models::Units::Hangar",  :foreign_key => "base_id"
        has_one :parking, :class_name => "S2C::Models::Units::Parking", :foreign_key => "base_id"

        validates_presence_of :position
        validates_presence_of :stuff

        after_create :update_base_id

        def setup
          super

          self.stuff    = S2C::Global.config["planet"]["stuff"]
          self.base_id  = 0
        end

        def add_ship
          self.ships.create! if !parking.full?
        end

        def add_stuff( _stuff )
          self.stuff += _stuff
          self.stuff = silo.capacity if stuff > silo.capacity

          self.save!
        end

        def remove_stuff( stuff )
          self.stuff -= stuff
          self.save!
        end

        def update_base_id
          self.update_attributes( :base_id => self.id )
        end

        def name
          "planet"
        end

      end
    end
  end
end