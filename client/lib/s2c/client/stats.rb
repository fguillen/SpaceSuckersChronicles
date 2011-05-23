module S2C
  module Client
    class Stats
      def self.stats( universe, type = :console )
        result = []
      
        result << S2C::Client::Stats.console_line( universe, universe['stats'] )
      
        universe['planets'].each do |planet|
          result << "  |- #{S2C::Client::Stats.console_line( planet, planet['stats'] )}"
          planet['constructions'].each do |construction|
            result << "  |    |- " +
                      S2C::Client::Stats.console_line( construction, construction['stats'] )
          end
        end

        result
      end
    
      def self.console_line( element, message )
        Kernel.sprintf( "[#{element['identity'].to_s.ljust( 11 )}] > #{message}" )
      end
    end
  end
end