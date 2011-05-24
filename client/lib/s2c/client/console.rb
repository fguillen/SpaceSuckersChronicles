module S2C
  module Client
    class Console
    
      attr_reader :host, :commander
    
      def initialize(host)
        @host       = host
        @exit       = false
        @commander  = S2C::Client::Commander.new(host)
      end
    
      def run
        while(!@exit)
          menu
        end
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
        commander.create_planet('x23')
        commander.create_planet('x24')
        commander.create_planet('x25')
      
        commander.build_mine('x23')
        commander.build_ship('x23')
        commander.build_ship('x23')
        
        stats
      end
    
      def create_planet_menu
        name = ask("Name? ")
        commander.create_planet(name)
        
        stats
      end
    
      def build_mine_menu
        planets = commander.get_planets
        
        choose do |menu|
          menu.prompt = "Planet?  "

          planets.each do |planet|
            menu.choice(planet['name']) do 
              commander.build_mine(planet['name'])
            end
          end
        end
        
        stats
      end
    
      def build_ship_menu
        planets = commander.get_planets
        
        choose do |menu|
          menu.prompt = "Planet?  "

          planets.each do |planet|
            menu.choice(planet['name']) do 
              commander.build_ship(planet['name'])
            end
          end
        end
        
        stats
      end
    
      def travel_menu
        ships   = commander.get_ships
        planets = commander.get_planets
        
        ship_identity = 
          choose do |menu|
            menu.prompt = "Ship?  "

            ships.each do |ship|
              menu.choice(ship['identity']) { ship['identity'] }
            end
          end
        
        choose do |menu|
          menu.prompt = "To planet?  "

          planets.each do |planet|
            menu.choice(planet['name']) do
              commander.travel(ship_identity, planet['name'])
            end
          end
        end
        
        stats
      end
    
      def log
        puts commander.log
      end
    
      def stats
        puts commander.stats
      end
    
      def map
        puts commander.map
      end
    end
  end
end