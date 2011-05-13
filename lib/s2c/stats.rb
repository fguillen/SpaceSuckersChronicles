module S2C
  class Stats
    def self.stats( universe, type = :console )
      result = []
      result << "--STATS INI--"

      result << S2C::Stats.console_line( universe, universe.stats )
      universe.planets.each do |planet|
        result << S2C::Stats.console_line( planet, planet.stats )
        planet.constructions.each do |construction|
          result << S2C::Stats.console_line( construction, construction.stats )
        end
      end

      result << "--STATS END--"
    end
    
    def self.console_line( element, message )
      Kernel.sprintf( "[%10s] > %s", element.identity, message )
    end
  end
end