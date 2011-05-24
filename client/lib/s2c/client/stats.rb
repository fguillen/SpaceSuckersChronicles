module S2C
  module Client
    class Stats
      def self.stats(universe, type = :console)
        result = []
        result << S2C::Client::Stats.console_line(universe, universe['stats'])
      
        universe['planets'].each do |planet|          
          result << 
            HighLine.new.color("  |-", :red) + 
            "#{S2C::Client::Stats.console_line(planet, planet['stats'])}"
          
          planet['constructions'].each do |construction|
            result << 
              HighLine.new.color("  |    |-", :red) +
              S2C::Client::Stats.console_line(construction, construction['stats'])
          end
        end

        result
      end
    
      def self.console_line(element, message)
        head      = HighLine.new.color("[#{element['identity'].to_s.ljust(11)}]", :green)
        separator = HighLine.new.color(">", :red)
        message   = HighLine.new.color(message, :bold)
        
        if(element['status'] && element['status'] != 'standby' )
          message = HighLine.new.color(message, :blink)
        end
        
        if(element['type'] == 'ship' )
          message = HighLine.new.color(message, :magenta)
        end
        
        if(element['type'] == 'mine' )
          message = HighLine.new.color(message, :yellow)
        end
        
        "#{head} #{separator} #{message}"
      end
    end
  end
end