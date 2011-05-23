require 'highline/import'

module S2C
  module Client
    class Console
    
      attr_reader :host
    
      def initialize(host)
        @host = host
        @exit = false
      end
    
      def run
        while( !@exit )
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
        Curl::Easy.http_post("http://#{host}/universe/planet", "name=x23")
        Curl::Easy.http_post("http://#{host}/universe/planet", "name=x24")
        Curl::Easy.http_post("http://#{host}/universe/planet", "name=x25")
      
        Curl::Easy.http_post("http://#{host}/universe/planets/x23/mines")
        Curl::Easy.http_post("http://#{host}/universe/planets/x23/ships")
        Curl::Easy.http_post("http://#{host}/universe/planets/x23/ships")
      end
    
      def create_planet_menu
        name = ask( "Name? " )
        Curl::Easy.http_post("http://#{host}/universe/planet", "name=#{name}")
      end
    
      def build_mine_menu
        c = Curl::Easy.new("http://#{host}/universe/planets")
        c.perform
        planets = JSON.parse(c.body_str)
        
        choose do |menu|
          menu.prompt = "Planet?  "

          planets.each do |planet|
            menu.choice(planet['name']) do 
              Curl::Easy.http_post(
                "http://#{host}/universe/planets/#{planet['name']}/mines"
              )
            end
          end
        end      end
    
      def build_ship_menu
        c = Curl::Easy.new("http://#{host}/universe/planets")
        c.perform
        planets = JSON.parse(c.body_str)
        
        choose do |menu|
          menu.prompt = "Planet?  "

          planets.each do |planet|
            menu.choice(planet['name']) do 
              Curl::Easy.http_post(
                "http://#{host}/universe/planets/#{planet['name']}/ships"
              )
            end
          end
        end
      end
    
      def travel_menu
        c = Curl::Easy.new("http://#{host}/universe/ships")
        c.perform
        ships = JSON.parse(c.body_str)
        
        c = Curl::Easy.new("http://#{host}/universe/planets")
        c.perform
        planets = JSON.parse(c.body_str)
        
        ship_identity = 
          choose do |menu|
            menu.prompt = "Ship?  "

            ships.each do |ship|
              menu.choice(ship['identity']) { ship['identity'] }
            end
          end
        
        puts "XXX: ship_identity: #{ship_identity}"
        
        choose do |menu|
          menu.prompt = "To planet?  "

          planets.each do |planet|
            menu.choice(planet['name']) do
              Curl::Easy.http_post(
                "http://#{host}/universe/ships/#{ship_identity}/travel",
                "planet_name=#{planet['name']}"
              )
            end
          end
        end
      end
    
      def log
        c = Curl::Easy.new("http://#{host}/universe")
        c.perform
        universe = JSON.parse(c.body_str)
        
        puts universe['logs'].join("\n")
      end
    
      def stats
        c = Curl::Easy.new("http://#{host}/universe")
        c.perform
        universe = JSON.parse(c.body_str)
        
        puts S2C::Client::Stats.stats(universe).join( "\n" )
      end
    
      def map
        c = Curl::Easy.new("http://#{host}/universe")
        c.perform
        universe = JSON.parse(c.body_str)
        
        puts universe['map'].join( "\n" )
      end
    end
  end
end