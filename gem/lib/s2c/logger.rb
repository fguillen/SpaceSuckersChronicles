module S2C
  class Logger
    def initialize( universe )
      @universe = universe
    end

    def log( element, message )
      message = format( element, message )
      puts message
    end

    def format( element, message )
      Kernel.sprintf(
        "(%010d) [%10s] > %s",
        @universe.tick,
        element.id,
        message
      )
    end
  end
end
