require 'yaml'

module S2C
  class Config

    def initialize( config_path )
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