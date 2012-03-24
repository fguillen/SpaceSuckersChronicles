require 'benchmark'

module S2C
  module Global
    def self.setup( config_path )
      @config   = S2C::Config.new( config_path )
      @universe = S2C::Universe.new
      @logger   = S2C::Logger.new( @universe )
      @store    = S2C::Store.new( @universe )
    end

    def self.config
      @config
    end

    def self.universe
      @universe
    end

    def self.logger
      @logger
    end

    def self.store
      @store
    end
  end
end