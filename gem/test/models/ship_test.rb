require_relative "../test_helper"

class ShipTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Planet.new( [1, 1] )
    @ship   = S2C::Models::Ship.new( @planet )
  end

  def test_initialize
    assert_equal( false,    @ship.id.nil? )
    assert_equal( 10,       @ship.life )
    assert_equal( 10,       @ship.atack )
    assert_equal( 5,        @ship.defense )
    assert_equal( @planet,  @ship.base)
  end

end