module S2C
  class Universe
    attr_accessor :planets, :log
    
    def initialize
      S2C::Universe.log( self, "Initializing Universe" )
      @planets = []
      @log = []
      S2C::Universe.log( self, "Universe intialized" )
    end
    
    def create_planet( name )
      planet = S2C::Models::Planet.new( name )
      
      @planets << planet
      
      return planet
    end
    
    def cycle
      S2C::Universe.log( self, "Start cycle" )
      @planets.each do |planet|
        planet.constructions.each do |construction|
          construction.work
        end
      end
      S2C::Universe.log( self, "End cycle" )
    end
    
    def run
      S2C::Universe.log( self, "Start run" )
      while( true )
        self.cycle
        self.stats
        sleep( 2 )
      end
      S2C::Universe.log( self, "End run" )
    end
    
    def id
      'Universe'
    end
    
    def self.log( element, message )
      puts "[#{element.id}] > #{message}"
    end
    
    def to_s
      "planets:#{self.planets.size}"
    end
    
    def stats
      puts "--STATS INI--"
      
      puts "[Universe] > #{self.to_s}"
      self.planets.each do |planet|
        puts "[#{planet.id}] > #{planet.to_s}"
        planet.constructions.each do |construction|
          puts "[#{construction.id}] > #{construction.to_s}"
        end
      end
      
      puts "--STATS END--"
    end
  end
end