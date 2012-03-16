require_relative "../test_helper"

class PlanetTest < Test::Unit::TestCase
  def setup
    @planet = S2C::Models::Planet.new( [1, 1] )
  end

  def test_initialize
    assert_equal( false,  @planet.id.nil? )
    assert_equal( 0,      @planet.units.size )
    assert_equal( [1, 1], @planet.position )
  end
end