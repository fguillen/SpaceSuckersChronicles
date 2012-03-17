require_relative 'test_helper'
require "json"

class UniverseTest < Test::Unit::TestCase
  def setup
    super

    @universe = S2C::Universe.new
  end

  def test_initialize
    assert_equal( [], @universe.planets )
    assert_equal( [], @universe.units )
    assert_equal( 0, @universe.tick )
  end


  def test_step
    unit1 = mock()
    unit2 = mock()
    unit1.expects( :work )
    unit2.expects( :work )

    @universe.instance_variable_set( :@tick, 1 )
    @universe.instance_variable_set( :@units, [unit1, unit2] )

    @universe.step

    assert_equal(2, @universe.tick)
  end

  def test_ships
    fleet  = S2C::Models::Fleet.new( nil, nil, nil )
    ship1  = S2C::Models::Ship.new( nil )
    ship2  = S2C::Models::Ship.new( nil )

    @universe.instance_variable_set( :@units, [fleet, ship1, ship2] )

    assert_equal( [ship1, ship2].map( &:id ), @universe.ships.map( &:id ) )
  end

  def test_get_planet
    planet1 = S2C::Models::Planet.new( [1, 1] )
    planet2 = S2C::Models::Planet.new( [1, 1] )

    @universe.instance_variable_set( :@units, [planet1, planet2] )

    assert_equal( planet2.id, @universe.get_planet( planet2.id ).id )
  end

  def test_get_unit
    planet1  = S2C::Models::Planet.new( [1, 1] )
    ship1    = S2C::Models::Ship.new( planet1 )
    ship2    = S2C::Models::Ship.new( planet1 )

    @universe.instance_variable_set( :@units, [ship1, ship2] )

    assert_equal( ship1.id, @universe.get_unit( ship1.id ).id )
  end


end