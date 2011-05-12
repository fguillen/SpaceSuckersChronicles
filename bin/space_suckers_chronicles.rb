require_relative '../lib/s2c'

universe = S2C::Universe.new
planet = universe.create_planet( 'X700' )
planet.build_mine
universe.run
