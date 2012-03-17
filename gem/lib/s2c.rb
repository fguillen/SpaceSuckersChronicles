require 'rubygems'

require_relative 's2c/version'
require_relative 's2c/utils'
require_relative 's2c/logger'
require_relative 's2c/store'
require_relative 's2c/models/planet'
require_relative 's2c/models/unit'
require_relative 's2c/models/ship'
require_relative 's2c/models/fleet'
require_relative 's2c/jobs/base'
require_relative 's2c/jobs/travel'
require_relative 's2c/jobs/combat'
require_relative 's2c/universe'
require_relative 's2c/global'
require_relative 's2c/jsoner'

puts "Loaded S2C gem version #{S2C::VERSION}"