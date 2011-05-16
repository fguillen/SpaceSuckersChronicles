module S2C
  module Models
    class Planet
      attr_reader :universe, :black_stuff, :name, :constructions, :position
    
      def initialize( universe, name, position = nil )
        universe.log( self, "Creating planet" )
        @black_stuff    = 20
        @name           = name
        @constructions  = []
        @universe       = universe
        @position       = position || [rand( S2C::Config.config['universe']['dimension'] ), rand( S2C::Config.config['universe']['dimension'] )]
      end
    
      def add_black_stuff( amount )
        universe.log( self, "Adding #{amount} black stuff to planet #{name}" )
        @black_stuff += amount
      end
    
      def remove_black_stuff( amount )
        universe.log( self, "Removing #{amount} black stuff to planet #{name}" )
        @black_stuff -= amount
      end
    
      def build_mine
        universe.log( self, "Building a mine" )
        construction = S2C::Models::Mine.new( self )
        @constructions << construction
        
        construction
      end
      
      def build_ship
        universe.log( self, "Building a ship" )
        construction = S2C::Models::Ship.new( self )
        @constructions << construction
        
        construction
      end
      
      def identity
        name || '-'
      end
      
      def stats
        result = ""
        result += "position:[#{position[0]},#{position[1]}]".ljust( 20 )
        result += "constructions:#{constructions.size}".ljust( 20 )
        result += "black_stuff:#{black_stuff}"
      end
    end
  end
end