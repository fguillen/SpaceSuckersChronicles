require_relative 'test_helper'

class MineTest < Test::Unit::TestCase
  def setup
    @config   = S2C::Config.new("#{FIXTURES_PATH}/config.yml")
    @universe = S2C::Universe.new(@config)
    @planet   = @universe.create_planet( [1, 1] )
  end

  def test_initialize
    mine = S2C::Models::Mine.new(@planet)

    assert_not_nil(mine.id)
    assert_equal(@universe, mine.universe)
    assert_equal(@planet, mine.planet)
    assert_equal(0, mine.level)
    assert_equal('mine', mine.type)
    assert_equal(:under_construction, mine.status)
    assert_equal(13, mine.instance_variable_get(:@process_remaining_ticks))
  end

  def test_work_standby
    mine = S2C::Models::Mine.new(@planet)
    mine.instance_variable_set(:@status, :standby)
    mine.planet.instance_variable_set(:@black_stuff, 1)
    mine.stubs(:power).returns(666)

    mine.work_standby

    assert_equal(667, mine.planet.black_stuff)
  end
end