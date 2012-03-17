require_relative 'test_helper'
require "json"

class StoreTest < Test::Unit::TestCase
  def setup
    super

    @universe = S2C::Universe.new
    @store  = S2C::Store.new( @universe )
  end

  def test_next_id
    @store.instance_variable_set( :@last_id, 23 )

    assert_equal( "X024", @store.next_id( "X" ) )
    assert_equal( "X025", @store.next_id( "X" ) )
  end

  def test_create_planet
    planet = @store.create_planet( [1,2] )

    assert_equal( [1,2], planet.position )
    assert_equal( 1, @universe.planets.size )
    assert_equal( planet.id, @universe.planets.first.id )
  end

  def test_create_fleet
    planet      = S2C::Models::Planet.new( [1, 1] )
    destination = S2C::Models::Planet.new( [1, 1] )
    ship        = S2C::Models::Ship.new( planet )

    planet.units = [ship]

    fleet = @store.create_fleet( planet, destination, [ship] )

    assert_equal( 1, @universe.units.size )
    assert_equal( fleet.id, @universe.units.first.id )
    assert_equal( 0, planet.units.size )
  end

  def test_create_ship
    planet  = S2C::Models::Planet.new( [1, 1] )

    ship    = @store.create_ship( planet )

    assert_equal( 1, planet.units.size )
    assert_equal( ship.id, planet.units.first.id )
    assert_equal( 1, @universe.units.size )
    assert_equal( ship.id, @universe.units.first.id )
  end

end
