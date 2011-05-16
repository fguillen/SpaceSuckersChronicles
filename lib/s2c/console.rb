require 'highline/import'

module S2C
  class Console
    def initialize
      @universe = Universe.new( S2C::Config.config['universe'] )
      @universe.start
      @exit = false
    end
    
    def run
      while( !@exit )
        menu
      end
      
      @universe.end
    end
    
    def menu
      choose do |menu|
        menu.prompt = "You wish?  "

        menu.choice(:seed) { seed }
        menu.choice(:create_planet) { create_planet_menu }
        menu.choice(:build_mine) { build_mine_menu }
        menu.choice(:build_ship) { build_ship_menu }
        menu.choice(:travel) { travel_menu }
        menu.choice(:log) { log }
        menu.choice(:stats) { stats }
        menu.choice(:map) { map }
        menu.choice(:exit) { @exit = true }
      end
    end
    
    def seed
      planet1 = @universe.create_planet( 'x23' )
      planet2 = @universe.create_planet( 'x24' )
      planet3 = @universe.create_planet( 'x25' )
      
      mine = planet1.build_mine
      ship = planet1.build_ship
      ship2 = planet1.build_ship
    end
    
    def create_planet_menu
      name = ask( "Name? " )
      @universe.create_planet( name )
    end
    
    def build_mine_menu
      choose do |menu|
        menu.prompt = "Planet?  "

        @universe.planets.each do |planet|
          menu.choice( planet.name ) { planet.build_mine }
        end
      end
    end
    
    def build_ship_menu
      choose do |menu|
        menu.prompt = "Planet?  "

        @universe.planets.each do |planet|
          menu.choice( planet.name ) { planet.build_ship }
        end
      end
    end
    
    def travel_menu
      ship = 
        choose do |menu|
          menu.prompt = "Ship?  "

          @universe.ships.each do |ship|
            menu.choice( ship.identity ) { ship }
          end
        end
        
      choose do |menu|
        menu.prompt = "To planet?  "

        @universe.planets.each do |planet|
          menu.choice( planet.name ) { ship.travel( planet ) }
        end
      end
    end
    
    def log
      puts @universe.print_logs.join( "\n" )
    end
    
    def stats
      puts S2C::Stats.stats( @universe ).join( "\n" )
    end
    
    def map
      puts @universe.map.join( "\n" )
    end
  end
end
