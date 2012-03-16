require_relative 'test_helper'
require "json"

class BuilderTest < Test::Unit::TestCase
  def setup
    @universe = S2C::Universe.new
  end

  def test_planet
    planet = S2C::Builder.planet( @universe, [1,2] )

    assert_equal( [1,2], planet.position )
    assert_equal( 1, @universe.planets.size )
    assert_equal( planet.id, @universe.planets.first.id )
  end

  def test_fleet
    planet      = S2C::Models::Planet.new( [1, 1] )
    destination = S2C::Models::Planet.new( [1, 1] )
    ship        = S2C::Models::Ship.new( planet )

    planet.units = [ship]

    fleet = S2C::Builder.fleet( @universe, planet, destination, [ship] )

    assert_equal( 1, @universe.units.size )
    assert_equal( fleet.id, @universe.units.first.id )
    assert_equal( 0, planet.units.size )
  end

  def test_ship
    planet  = S2C::Models::Planet.new( [1, 1] )

    ship    = S2C::Builder.ship( @universe, planet )

    assert_equal( 1, planet.units.size )
    assert_equal( ship.id, planet.units.first.id )
    assert_equal( 1, @universe.units.size )
    assert_equal( ship.id, @universe.units.first.id )
  end

end
