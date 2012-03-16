require 'benchmark'

module S2C
  module Global
    attr_reader :universe, :logger, :store

    @universe = S2C::Universe.new
    @logger   = S2C::Logger.new( @universe )
    @store    = S2C::Store.new( @universe )

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