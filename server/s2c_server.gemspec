# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "s2c/server/version"

Gem::Specification.new do |s|
  s.name        = "s2c_server"
  s.version     = S2C::Server::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fernando Guillen"]
  s.email       = ["fguillen.mail@gmail.com"]
  s.homepage    = "http://fernandoguillen.info"
  s.summary     = "HTTP REST API S2C server"
  s.description = "Server that starts a 'Space Suckers Chronicles' instance and publishs an HTTP REST API"

  s.rubyforge_project = "s2c_server"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency( "sinatra" )
  s.add_dependency( "json" )
end
