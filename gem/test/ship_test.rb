require_relative 'test_helper'

class ShipTest < Test::Unit::TestCase

  def setup
    @config   = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    @universe = S2C::Universe.new(@config)
    @planet = @universe.create_planet( [1, 1] )
  end

  def test_initialize
    @universe.expects( :generate_id ).with( "A" ).returns( "A000" )
    ship = S2C::Models::Ship.new(@planet)

    assert_equal( "A000", ship.id )
    assert_equal(@universe, ship.universe)
    assert_equal(@planet, ship.planet)
    assert_equal(0, ship.level)
    assert_equal('ship', ship.type)
    assert_equal(:under_construction, ship.status)
    assert_equal(33, ship.instance_variable_get(:@process_remaining_ticks))
  end

  def test_travel
    planet_origin = @universe.create_planet( [1, 1] )
    planet_destiny = @universe.create_planet( [1, 1] )

    ship = S2C::Models::Ship.new(planet_origin)
    ship.instance_variable_set(:@status, :standby)
    ship.instance_variable_set(:@traveling_to, nil)
    ship.instance_variable_set(:@process_remaining_ticks, 1)

    ship.planet.instance_variable_set(:@black_stuff, 12)

    ship.
      expects(:travel_consume_black_stuff).
      with(ship.planet, planet_destiny, 2).
      returns(11)

    ship.
      expects(:travel_ticks).
      with(ship.planet, planet_destiny, ship.velocity).
      returns(3)

    ship.travel(planet_destiny)
    assert_equal(:traveling, ship.status)
    assert_equal(planet_destiny, ship.traveling_to)
    assert_equal(1, ship.planet.black_stuff)
    assert_equal(3, ship.process_remaining_ticks)
  end

  def test_travel_not_in_standby_should_returns_false
    planet_destiny = @universe.create_planet( [1, 1] )

    ship = S2C::Models::Ship.new(@planet)
    ship.instance_variable_set(:@status, :under_construction)
    ship.instance_variable_set(:@traveling_to, nil)
    ship.instance_variable_set(:@process_remaining_ticks, 1)

    assert_equal(false, ship.travel(planet_destiny))
    assert_equal(:under_construction, ship.status)
    assert_equal(1, ship.process_remaining_ticks)
    assert_match("ERROR", @universe.logs.last)
  end

  def test_travel_not_enough_black_stuff_should_returns_false
    planet_destiny = @universe.create_planet( [1, 1] )

    ship = S2C::Models::Ship.new(@planet)
    ship.instance_variable_set(:@status, :standby)
    ship.instance_variable_set(:@traveling_to, nil)
    ship.instance_variable_set(:@process_remaining_ticks, 1)

    ship.planet.expects(:black_stuff).returns(10)

    ship.
      expects(:travel_consume_black_stuff).
      with(ship.planet, planet_destiny, 2).
      returns(11)

    assert_equal(false, ship.travel(planet_destiny))
    assert_equal(:standby, ship.status)
    assert_equal(1, ship.process_remaining_ticks)
    assert_match("ERROR", @universe.logs.last)
  end

  def test_work_traveling
    ship = S2C::Models::Ship.new(@planet)
    ship.instance_variable_set(:@status, :traveling)
    ship.instance_variable_set(:@process_remaining_ticks, 1)

    ship.work_traveling
    assert_equal(:traveling, ship.status)
  end

  def test_work_traveling_finished
    planet_origin = @universe.create_planet( [1, 1] )
    planet_destiny = @universe.create_planet( [1, 1] )

    ship = S2C::Models::Ship.new(planet_origin)
    ship.instance_variable_set(:@status, :traveling)
    ship.instance_variable_set(:@traveling_to, planet_destiny)
    ship.instance_variable_set(:@process_remaining_ticks, 0)

    ship.work_traveling
    assert_equal(planet_destiny.id, ship.planet.id)
    assert_equal(0, planet_origin.units.size)
    assert_equal(1, planet_destiny.units.size)
    assert_equal(ship, planet_destiny.units.first)
    assert_equal(:standby, ship.status)
    assert_nil(ship.traveling_to)
  end

  def test_to_hash
    ship            = S2C::Models::Ship.new(@planet)
    planet_destiny  = @universe.create_planet( [1, 1] )

    ship.stubs(:traveling_to).returns(planet_destiny)

    assert_equal(planet_destiny.id, ship.to_hash[:traveling_to])
  end

  def test_from_opts
    opts = {
      "level" => 101
    }

    ship = S2C::Models::Ship.new( @planet, opts )

    assert_equal( 101, ship.level )
  end

end