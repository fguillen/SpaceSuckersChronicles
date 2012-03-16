module S2C
  class Logger
    def initialize( universe )
      @universe = universe
    end

    def self.log( element, message )
      message =
        Kernel.sprintf(
          "(%010d) [%10s] > %s",
          @universer.tick,
          element.id,
          message
       )

      puts message
    end
  end
end
