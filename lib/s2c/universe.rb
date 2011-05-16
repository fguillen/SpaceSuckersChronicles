require 'benchmark'

module S2C
  class Universe
    attr_accessor :planets, :logs, :status, :tick
    
    def initialize
      @logs     = []
      @planets  = []
      @tick     = 0 # Universe's time
    end
    
    def create_planet( name, position = nil )
      planet = S2C::Models::Planet.new( self, name, position )
      
      @planets << planet
      
      planet
    end
    
    def cycle
      self.log( self, "Start cycle" )
      
      @planets.each do |planet|
        planet.constructions.each do |construction|
          construction.work
        end
      end
      
      @tick += 1
      
      self.log( self, "End cycle" )
    end
    
    def start
      Thread.new { self.run }
    end
    
    def end
      @status = :ending
    end
    
    def run
      self.log( self, "Start run" )
      
      while( self.status != :ending )
        time =
          Benchmark.realtime do
            self.cycle
          end

        sleep( S2C::Config.config['universe']['tick_seconds'].to_i - time )
      end
      
      self.log( self, "End run" )
    end
    
    def identity
      'Universe'
    end
    
    def stats
      "planets:#{self.planets.size}"
    end
    
    def log( element, message )
      @logs << Kernel.sprintf( "(%010d) [%10s] > %s", self.tick, element.identity, message )
    end
    
    def print_logs( last_lines = 10 )
      last_lines = self.logs.size  if last_lines > self.logs.size
      
      self.logs[-(last_lines),last_lines]
    end
    
    def map
      universe_dimension = S2C::Config.config['universe']['dimension']
      
      result = Array.new( universe_dimension ) { ' ' * universe_dimension }

      self.planets.each do |planet|
        line = result[ planet.position[0] ]
        line[ planet.position[1] ] = "*#{planet.identity}"
      end
      
      result
    end
    
    def ships
      result = []
      
      @planets.each do |planet|
        result += planet.constructions.select { |e| e.type == 'ship' }
      end

      result
    end
  end
end