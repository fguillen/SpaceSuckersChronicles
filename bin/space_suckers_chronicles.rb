require_relative '../lib/s2c'

require './lib/s2c'
u = S2C::Universe.new
p = u.create_planet( 'X700' )
p.build_mine


universe.start

print S2C::Stats.stats( u ).join("\n")
print u.map.join("\n")

S2C::Utils.travel_black_stuff( p, p2 )

