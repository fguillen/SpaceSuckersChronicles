require 'test/unit'
require 'mocha'
require 'ruby-debug'
require 'delorean'

require_relative '../lib/s2c' 

FIXTURES_PATH = File.expand_path("#{File.dirname(__FILE__)}/fixtures")