require 'benchmark'

module S2C
  class Universe
    attr_accessor(
      :planets, 
      :logs, 
      :status, 
      :tick, 
      :size, 
      :config
    )
    
    def initialize( config )
      @logs     = []
      @planets  = []
      @config   = config
      @size     = config['universe']['size']
      @tick     = 0 # Universe's time
    end
    
    def create_planet( name, position = nil )
      planet = S2C::Models::Planet.new( self, name, position )
      
      @planets << planet
      
      planet
    end
    
    def cycle
      log( self, "Start cycle" )
      
      @planets.each do |planet|
        planet.constructions.each do |construction|
          construction.work
        end
      end
      
      @tick += 1
      
      log( self, "End cycle" )
    end
    
    def start
      puts "XXX: START"
      Thread.new { run }
    end
    
    def end
      @status = :ending
    end
    
    def run
      log( self, "Start run" )
      
      while( status != :ending )
        time =
          Benchmark.realtime do
            cycle
          end

        sleep( config['universe']['tick_seconds'].to_i - time )
      end
      
      log( self, "End run" )
    end
    
    def identity
      'Universe'
    end
    
    def stats
      "planets:#{planets.size}"
    end
    
    def log( element, message )
      @logs << 
        Kernel.sprintf( 
          "(%010d) [%10s] > %s", 
          tick, 
          element.identity, 
          message
        )
    end
    
    def print_logs( last_lines = 10 )
      last_lines = logs.size  if last_lines > logs.size
      
      logs[-(last_lines),last_lines]
    end
    
    def map
      result = Array.new( size ) { ' ' * size }

      planets.each do |planet|
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
    
    def get_planet(name)
      planets.select { |e| e.name == name }.first
    end
    
    def get_ship(identity)
      ships.select { |e| e.identity == identity }.first
    end
    
    def to_hash
      planets_hash = planets.map { |e| e.to_hash }
      
      {
        :planets  => planets_hash,
        :logs     => logs,
        :status   => status,
        :tick     => tick,
        :size     => size
      }
    end
  end
end