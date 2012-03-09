require_relative 'test_helper'

class UtilsTest < Test::Unit::TestCase
  def setup
    @config = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    S2C::Config.stubs(:config_path).returns("#{FIXTURES_PATH}/config.yml")
  end

  def test_planet_distance
    universe = S2C::Universe.new(@config)

    planet1 = S2C::Models::Planet.new(universe, "position" => [0,0])
    planet2 = S2C::Models::Planet.new(universe, "position" => [0,0])
    assert_equal(0, S2C::Utils.planet_distance(planet1, planet2))

    planet1 = S2C::Models::Planet.new(universe, "position" => [0,0])
    planet2 = S2C::Models::Planet.new(universe, "position" => [1,1])
    assert_equal(1, S2C::Utils.planet_distance(planet1, planet2))

    planet1 = S2C::Models::Planet.new(universe, "position" => [0,0])
    planet2 = S2C::Models::Planet.new(universe, "position" => [5,5])
    assert_equal(7, S2C::Utils.planet_distance(planet1, planet2))

    planet1 = S2C::Models::Planet.new(universe, "position" => [0,0])
    planet2 = S2C::Models::Planet.new(universe, "position" => [5,10])
    assert_equal(11, S2C::Utils.planet_distance(planet1, planet2))

    planet1 = S2C::Models::Planet.new(universe, "position" => [10,5])
    planet2 = S2C::Models::Planet.new(universe, "position" => [0,0])
    assert_equal(11, S2C::Utils.planet_distance(planet1, planet2))
  end

  def test_travel_black_stuff
    S2C::Utils.expects(:planet_distance).returns(1)
    assert_equal(2, S2C::Utils.travel_consume_black_stuff(nil, nil, 2))

    S2C::Utils.expects(:planet_distance).returns(2)
    assert_equal(4, S2C::Utils.travel_consume_black_stuff(nil, nil, 2))
  end

  def test_travel_ticks
    S2C::Utils.expects(:planet_distance).returns(1)
    assert_equal(1, S2C::Utils.travel_ticks(nil, nil, 1))

    S2C::Utils.expects(:planet_distance).returns(8)
    assert_equal(4, S2C::Utils.travel_ticks(nil, nil, 2))
  end

  def test_remaining_ticks_to_time
    Delorean.time_travel_to(Time.new(2010, 11, 12, 13, 14, 15)) do
      finish_time = S2C::Utils.remaining_ticks_to_time(2, 1800)

      assert_equal(
        "2010-11-12 14:14:15",
        finish_time.strftime('%Y-%m-%d %H:%M:%S')
     )
    end
  end

  def test_feed_universe
    universe = S2C::Universe.new( @config )
    S2C::Utils.feed_universe( universe )

    assert_equal( 11, universe.planets.size )
    assert_equal( 0, universe.fleets.size )
  end
end