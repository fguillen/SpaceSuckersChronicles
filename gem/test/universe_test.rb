require_relative 'test_helper'
require "json"

class UniverseTest < Test::Unit::TestCase
  def setup
    @config = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
  end

  def test_initialize
    universe = S2C::Universe.new(@config)

    assert_equal([], universe.logs)
    assert_equal([], universe.planets)
    assert_equal(0, universe.tick)
  end

  def test_create_planet
    universe = S2C::Universe.new(@config)

    planet = universe.create_planet( [1,2] )

    assert_equal(1, universe.planets.size)
    assert_equal(planet, universe.planets.first)
    assert_equal([1,2], planet.position)
  end

  def test_cycle
    universe = S2C::Universe.new(@config)
    universe.instance_variable_set(:@tick, 1)
    planet = universe.create_planet( [1, 1] )
    mine = planet.build_mine
    ship = planet.build_ship

    mine.expects(:work)
    ship.expects(:work)

    universe.cycle

    assert_equal(2, universe.tick)
  end


  def test_ships
    universe = S2C::Universe.new(@config)

    planet1 = universe.create_planet( [1, 1] )
    mine1 = planet1.build_mine
    ship1 = planet1.build_ship
    ship2 = planet1.build_ship

    planet2 = universe.create_planet( [1, 1] )
    ship3 = planet2.build_ship

    assert_equal([ship1, ship2, ship3], universe.ships)
  end

  def test_get_planet
    universe = S2C::Universe.new(@config)
    planet1 = universe.create_planet( [1, 1] )
    planet2 = universe.create_planet( [1, 1], "id" => "mercurio" )

    assert_equal( planet2, universe.get_planet( "mercurio" ) )
  end

  def test_get_ship
    universe = S2C::Universe.new(@config)
    planet1  = universe.create_planet( [1, 1] )
    ship1    = planet1.build_ship

    assert_equal(ship1, universe.get_ship(ship1.id))
  end

  def test_to_hash
    universe = S2C::Universe.new(@config)

    planet1 = universe.create_planet( [1, 1] )
    planet2 = universe.create_planet( [20, 20] )

    ship1   = planet1.build_ship
    ship2   = planet1.build_ship
    mine1   = planet1.build_mine
    fleet1  = planet1.build_fleet( planet2, [ship1, ship2] )

    universe.stubs(:logs).returns(['1','2'])
    universe.stubs(:status).returns('STATUS')
    universe.stubs(:tick).returns('TICK')

    universe_hash = universe.to_hash

    # assert_equal(['1', '2'], universe_hash[:logs])
    assert_equal('STATUS', universe_hash[:status])
    assert_equal('TICK', universe_hash[:tick])
    assert_equal(2, universe_hash[:planets].size)
    # assert_equal(
    #   ship1.id,
    #   universe_hash[:planets][0][:units][0][:id]
    # )
    assert_equal(
      fleet1.id,
      universe_hash[:fleets][0][:id]
    )
  end

  def test_from_hash
    hash = JSON.parse( File.read( "#{FIXTURES_PATH}/universe.json" ) )
    universe = S2C::Universe.new( @config )
    universe.from_hash( hash )

    assert_equal( 11, universe.planets.size )
    assert_equal( 5, universe.fleets.size )
    assert_equal( 24, universe.ships.size )
  end

  def test_generate_id
    universe = S2C::Universe.new(@config)
    universe.instance_variable_set( :@last_id, 23 )

    assert_equal( "X024", universe.generate_id( "X" ) )
    assert_equal( 24, universe.last_id )

  end
end