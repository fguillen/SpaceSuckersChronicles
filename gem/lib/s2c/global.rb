require 'benchmark'

module S2C
  module Global
    def self.setup( config_path )
      @config = S2C::Config.new( config_path )
      @logger = S2C::Logger.new( @config )

      initialize_active_record
    end

    def self.initialize_active_record
      log_path = File.expand_path( "#{config["log_path"]}/db.log" )

      ActiveRecord::Base.logger = ::Logger.new( log_path )
      ActiveRecord::Base.establish_connection(
        :adapter  => "sqlite3",
        :database => config["db_path"]
      )

      if( !File.exists?( config["db_path"] ) )
        puts( "Initializing DB in: '#{config["db_path"]}'..." )
        require_relative "./../../db/schema"
      end
   end

    def self.universe
      S2C::Models::Universe.find_or_create_by_name( config["universe"]["name"] )
    end

    def self.config
      @config
    end

    def self.logger
      @logger
    end
  end
end