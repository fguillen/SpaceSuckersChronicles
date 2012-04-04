module S2C
  class Logger
    attr_reader :config

    def initialize( config )
      @config = config
    end

    def log( element, message )
      message   = format( element, message )
      log_path  = File.expand_path( "#{config["log_path"]}/universe.log" )

      puts "XXX: #{message}"

      File.open( log_path, "a" ) { |f| f.write message }
    end

    def event( family, message)
      S2C::Global.universe.events.create!(
        :tick     => S2C::Global.universe.tick,
        :family   => family,
        :message  => message
      )
    end

    def format( element, message )
      Kernel.sprintf(
        "(%010d) [%10s] > %s",
        S2C::Global.universe.tick,
        element.id,
        message
      )
    end
  end
end
