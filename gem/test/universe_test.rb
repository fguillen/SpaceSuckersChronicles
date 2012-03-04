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

    planet = universe.create_planet('jupiter', [1,2])

    assert_equal(1, universe.planets.size)
    assert_equal(planet, universe.planets.first)
    assert_equal([1,2], planet.position)
  end

  def test_cycle
    universe = S2C::Universe.new(@config)
    universe.instance_variable_set(:@tick, 1)
    planet = universe.create_planet('jupiter')
    mine = planet.build_mine
    ship = planet.build_ship

    mine.expects(:work)
    ship.expects(:work)

    universe.cycle

    assert_equal(2, universe.tick)
  end


  def test_ships
    universe = S2C::Universe.new(@config)

    planet1 = universe.create_planet('jupiter')
    mine1 = planet1.build_mine
    ship1 = planet1.build_ship
    ship2 = planet1.build_ship

    planet2 = universe.create_planet('mercurio')
    ship3 = planet2.build_ship

    assert_equal([ship1, ship2, ship3], universe.ships)
  end

  def test_get_planet
    universe = S2C::Universe.new(@config)
    planet1 = universe.create_planet('jupiter')
    planet2 = universe.create_planet('mercurio')

    assert_equal(planet2, universe.get_planet('mercurio'))
  end

  def test_get_ship
    universe = S2C::Universe.new(@config)
    planet1  = universe.create_planet('jupiter')
    ship1    = planet1.build_ship

    assert_equal(ship1, universe.get_ship(ship1.id))
  end

  def test_to_hash
    universe = S2C::Universe.new(@config)

    planet1 = universe.create_planet('jupiter', [1, 1])
    planet2 = universe.create_planet('mercurio', [20, 20])

    ship1   = planet1.build_ship
    ship2   = planet1.build_ship
    mine1   = planet1.build_mine
    fleet1  = planet1.build_fleet( planet2, [ship1, ship2] )

    universe.stubs(:logs).returns(['1','2'])
    universe.stubs(:status).returns('STATUS')
    universe.stubs(:tick).returns('TICK')

    universe_hash = universe.to_hash

    puts "XXX: universe_hash: #{JSON.pretty_generate( universe_hash ) }"

    # assert_equal(['1', '2'], universe_hash[:logs])
    assert_equal('STATUS', universe_hash[:status])
    assert_equal('TICK', universe_hash[:tick])
    assert_equal(2, universe_hash[:planets].size)
    assert_equal(
      ship1.id,
      universe_hash[:planets][0][:constructions][0][:id]
    )
    assert_equal(
      fleet1.id,
      universe_hash[:fleets][0][:id]
    )
  end
end