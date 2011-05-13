module S2C
  module Models
    class Planet
      attr_reader :universe, :black_stuff, :name, :constructions, :position
    
      def initialize( universe, name, position = nil )
        universe.log( self, "Creating planet" )
        @black_stuff = 20
        @name = name
        @constructions = []
        @universe = universe
        @position = position || [rand( S2C::Config.config['universe']['dimension'] ), rand( S2C::Config.config['universe']['dimension'] )]
      end
    
      def add_black_stuff( amount )
        self.universe.log( self, "Adding #{amount} black stuff to planet #{self.name}" )
        @black_stuff += amount
      end
    
      def remove_black_stuff( amount )
        self.universe.log( self, "Removing #{amount} black stuff to planet #{self.name}" )
        @black_stuff -= black_stuff
      end
    
      def build_mine
        self.universe.log( self, "Building a mine" )
        construction = S2C::Models::Mine.new( self )
        @constructions << construction
        
        return construction
      end
      
      def build_ship
        self.universe.log( self, "Building a ship" )
        construction = S2C::Models::Ship.new( self )
        @constructions << construction
        
        return construction
      end
      
      def identity
        self.name || '-'
      end
      
      def stats
        result = ""
        result += "position:#{self.position[0]},#{self.position[1]}"
        result += " constructions:#{self.constructions.size}"
        result += " black_stuff:#{self.black_stuff}"
        
        return result
      end
    end
  end
end