require_relative 'test_helper'

class FleetTest < Test::Unit::TestCase

  def setup
    @config   = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    @universe = S2C::Universe.new(@config)
    @planet   = @universe.create_planet( 'jupiter', [1, 1] )
  end

  def test_initialize
    planet_destination = @universe.create_planet( 'jupiter', [10, 10] )
    ship1 = @planet.build_ship

    fleet = S2C::Models::Fleet.new( @planet, planet_destination, [ship1] )

    assert_not_nil( fleet.id )
    assert_equal( @universe,          fleet.universe )
    assert_equal( @planet,            fleet.planet )
    assert_equal( planet_destination, fleet.planet_destination )
    assert_equal( [ship1],            fleet.ships )
    assert_equal( 0,                  fleet.level )
    assert_equal( 'fleet',            fleet.type )
    assert_equal( :traveling,         fleet.status )
  end

end