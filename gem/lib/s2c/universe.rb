require 'benchmark'

module S2C
  class Universe
    attr_accessor(
      :planets,
      :units,
      :tick
   )

    def initialize
      @planets  = []
      @units    = []
      @tick     = 0 # Universe's time
    end

    def cycle
      @tick += 1

      S2C::Utils.log( self, "Start cycle" )

      @units.each do |unit|
        unit.work
      end

      S2C::Utils.log( self, "End cycle" )
    end

    def start
      Thread.new { run }
    end

    def end
      @status = :ending
    end

    def run
      S2C::Utils.log( self, "Start run" )

      while(status != :ending)
        time =
          Benchmark.realtime do
            begin
              cycle
            rescue Exception => e
              S2C::Utils.log( self, "ERROR: #{e}" )
              puts "XXX: backtrace:"
              puts e.backtrace.join( "\n" )
              raise e
            end
          end

        rest_time = config['universe']['tick_seconds'].to_f - time
        S2C::Utils.log( self, "Resting #{rest_time * 1000} millisecond" )
        sleep( rest_time )
      end

      S2C::Utils.log( self, "End run" )
    end

    def id
      'Universe'
    end

    def get_planet(id)
      planets.select { |e| e.id == id }.first
    end

    def get_unit(id)
      units.select { |e| e.id == id }.first
    end

  end
end