require_relative "../test_helper"
require "json"

class UniverseTest < Test::Unit::TestCase
  def setup
    super

    @universe = S2C::Global.universe
  end

  def test_setup
    assert_equal( 0, @universe.units.count )
    assert_equal( 0, @universe.tick )
  end

  def test_step
    unit1 = mock()
    unit2 = mock()
    unit1.expects( :work )
    unit2.expects( :work )

    @universe.stubs( :units ).returns( [unit1, unit2] )

    @universe.step

    assert_equal(1, @universe.tick)
  end

  def test_units
    S2C::Models::Units::Base.create!
    assert_equal( 1, @universe.units.count )

    S2C::Models::Units::Planet.create!( :position => [1, 2] )
    assert_equal( 2, @universe.units.count )
  end

  def test_ships
    planet = S2C::Models::Units::Planet.create!( :position => [1, 2] )
    ship1  = planet.ships.create!
    ship2  = planet.ships.create!

    assert_equal( [ship1, ship2].map( &:id ), @universe.ships.map( &:id ) )
  end

  def test_planets
    planet = S2C::Models::Units::Planet.create!( :position => [1, 2] )
    ship1  = planet.ships.create!
    ship2  = planet.ships.create!

    assert_equal( [planet].map( &:id ), @universe.planets.map( &:id ) )
  end

end