require_relative "../../test_helper"

class PlanetTest < Test::Unit::TestCase
  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 2] )
  end

  def test_setup
    assert_equal( 1,        @planet.position[0] )
    assert_equal( 2,        @planet.position[1] )
    assert_equal( 0,        @planet.ships.count )
    assert_equal( 1000,     @planet.stuff )
    assert_equal( "planet", @planet.name )
  end

  def test_add_ship
    @planet.add_ship
    @planet.reload
    assert_equal( 1, @planet.ships.count )
  end

  def test_add_stuff
    @planet.add_stuff( 10 )
    @planet.reload
    assert_equal( 1010, @planet.stuff )
  end
end