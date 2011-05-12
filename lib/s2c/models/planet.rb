module S2C
  module Models
    class Planet
      attr_reader :universe, :black_stuff, :name, :constructions
    
      def initialize( name )
        S2C::Universe.log( self, "Creating planet" )
        @black_stuff = 20
        @name = name
        @constructions = []
      end
    
      def add_black_stuff( amount )
        S2C::Universe.log( self, "Adding #{amount} black stuff to planet #{self.name}" )
        @black_stuff += amount
      end
    
      def remove_black_stuff( amount )
        S2C::Universe.log( self, "Removing #{amount} black stuff to planet #{self.name}" )
        @black_stuff -= black_stuff
      end
    
      def build_mine
        S2C::Universe.log( self, "Building a mine" )
        construction = S2C::Models::Mine.new( self )
        @constructions << construction
      end
      
      def id
        self.name
      end
      
      def to_s
        "constructions:#{self.constructions.size} black stuff:#{self.black_stuff}"
      end
    end
  end
end