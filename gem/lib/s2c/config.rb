require 'yaml'

module S2C
  class Config

    CONFIG_PATH = "#{File.dirname(__FILE__)}/../../config/config.yml"

    def initialize( config_path = CONFIG_PATH )
      load( config_path )
    end

    def []( key )
      @config[ key ]
    end

    private

    def load( config_path )
      @config ||= YAML.load( File.read( config_path ) )
    end

  end
end