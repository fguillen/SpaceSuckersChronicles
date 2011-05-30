# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "s2c/client/version"

Gem::Specification.new do |s|
  s.name        = "s2c_client"
  s.version     = S2C::Client::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fernando Guillen"]
  s.email       = ["fguillen.mail@gmail.com"]
  s.homepage    = "http://fernandoguillen.info"
  s.summary     = "Console client for the S2C HTTP REST API"
  s.description = "Menu based console client for send commands to a 'Space Suckers Chronicles' HTTP REST API server"

  s.rubyforge_project = "s2c_client"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('highline')
  s.add_dependency('curb')
  s.add_dependency('json')
end
