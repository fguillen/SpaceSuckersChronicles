require "rubygems"
require "active_record"
require "sqlite3"
require "logger"

require_relative "s2c/version"
require_relative "s2c/config"
require_relative "s2c/utils"
require_relative "s2c/logger"
require_relative "s2c/store"
require_relative "s2c/models/units/base"
require_relative "s2c/models/units/planet"
require_relative "s2c/models/units/ship"
require_relative "s2c/models/units/fleet"
require_relative "s2c/models/units/silo"
require_relative "s2c/models/units/mine"
require_relative "s2c/models/units/parking"
require_relative "s2c/models/units/hangar"
require_relative "s2c/models/jobs/base"
require_relative "s2c/models/jobs/travel"
require_relative "s2c/models/jobs/combat"
require_relative "s2c/models/jobs/upgrade"
require_relative "s2c/models/jobs/produce_stuff"
require_relative "s2c/models/jobs/build_ship"
require_relative "s2c/models/universe"
require_relative "s2c/global"
require_relative "s2c/jsoner"



puts "Loaded S2C gem version #{S2C::VERSION}"