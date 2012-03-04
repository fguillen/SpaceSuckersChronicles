require 'rubygems'

require_relative 's2c/version'
require_relative 's2c/utils'
require_relative 's2c/config'
require_relative 's2c/models/planet'
require_relative 's2c/models/construction'
require_relative 's2c/models/mine'
require_relative 's2c/models/ship'
require_relative 's2c/models/fleet'
require_relative 's2c/universe'

puts "Loaded S2C gem version #{S2C::VERSION}"