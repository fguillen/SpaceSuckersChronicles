require 'yaml'

module S2C
  class Config
    CONFIG_PATH = "#{File.dirname(__FILE__)}/../../config/config.yml"

    def self.config
      YAML.load( File.read( S2C::Config.config_path ) )
    end
        
    def self.config_path
      S2C::Config::CONFIG_PATH
    end
  end
end