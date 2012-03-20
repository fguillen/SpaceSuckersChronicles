# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "s2c/version"

Gem::Specification.new do |s|
  s.name        = "s2c"
  s.version     = S2C::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Fernando Guillen"]
  s.email       = ["fguillen.mail@gmail.com"]
  s.homepage    = "http://fernandoguillen.info"
  s.summary     = "Core S2C game engine"
  s.description = "All the core components for the 'Space Suckers Chronicles' text-based massively multiplayer online role-playing game"

  s.rubyforge_project = "s2c"

  s.add_development_dependency "bundler",   ">= 1.0.0.rc.6"
  s.add_development_dependency "rake",      "0.9.2.2"
  s.add_development_dependency "mocha"
  s.add_development_dependency "delorean"
  s.add_development_dependency "simplecov"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
