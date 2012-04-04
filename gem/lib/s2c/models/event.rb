module S2C
  module Models
    class Event < ActiveRecord::Base
      self.table_name = :events

      FAMILIES = [
        :fleet,
        :ship,
        :planet
      ]

      belongs_to :universe, :class_name => "S2C::Models::Universe"

      validates_presence_of :family
      validates_presence_of :message
      validates_presence_of :tick
      validates_presence_of :universe_id

      validates :family, :inclusion => { :in => FAMILIES }
    end
  end
end