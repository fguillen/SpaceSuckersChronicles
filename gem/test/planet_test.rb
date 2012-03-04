require_relative 'test_helper'

class PlanetTest < Test::Unit::TestCase
  def setup

    @config   = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    @universe = S2C::Universe.new(@config)
    @planet   = @universe.create_planet('jupiter')
  end

  def test_initialize
    planet = S2C::Models::Planet.new(@universe, 'saturn', [1, 1])

    assert_equal(1000, planet.black_stuff)
    assert_equal('saturn', planet.id)
    assert_equal(0, planet.constructions.size)
    assert_equal(@universe, planet.universe)
    assert_equal([1, 1], planet.position)
  end

  def test_add_black_stuff
    @planet.instance_variable_set(:@black_stuff, 1)

    @planet.add_black_stuff(3)

    assert_equal(4, @planet.black_stuff)
  end

  def test_remove_black_stuff
    @planet.instance_variable_set(:@black_stuff, 10)

    @planet.remove_black_stuff(3)

    assert_equal(7, @planet.black_stuff)
  end

  def test_build_mine
    @planet.instance_variable_set(:@constructions, [])

    @planet.build_mine

    assert_equal(1, @planet.constructions.size)
    assert_equal('mine', @planet.constructions.first.type)
    assert_equal(@planet, @planet.constructions.first.planet)
  end

  def test_build_ship
    @planet.instance_variable_set(:@constructions, [])

    @planet.build_ship

    assert_equal(1, @planet.constructions.size)
    assert_equal('ship', @planet.constructions.first.type)
    assert_equal(@planet, @planet.constructions.first.planet)
  end

  def test_id
    assert_equal('jupiter', @planet.id)
  end

  def test_to_hash
    ship1 = @planet.build_ship
    ship2 = @planet.build_ship
    mine1 = @planet.build_mine

    @planet.stubs(:position).returns([3,45])
    @planet.stubs(:black_stuff).returns(789)

    assert_equal('jupiter', @planet.to_hash[:id])
    assert_equal(789, @planet.to_hash[:black_stuff])
    assert_equal(3, @planet.to_hash[:constructions].size)
    assert_equal([3, 45], @planet.to_hash[:position])
    assert_equal(ship1.id, @planet.to_hash[:constructions][0][:id])
  end

end