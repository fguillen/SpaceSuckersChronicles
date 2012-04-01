require_relative '../test_helper'

class SiloUpgradeTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet     = @universe.planets.create!( :position => [1, 1] )
    @silo       = @planet.create_silo!
  end

  def test_setup
    assert_equal( 2,    @universe.units.size )
    assert_equal( nil,  @silo.job )
    assert_equal( 0,    @silo.level )
    assert_equal( 1000, @planet.stuff )
  end

  def test_upgrade
    @silo.start_upgrade
    @silo.reload
    @planet.reload

    assert( @silo.job.instance_of?( S2C::Models::Jobs::Upgrade ) )
    assert_equal( 980, @planet.stuff )
    assert_equal( 1, @silo.job.ticks_remain )
    assert_equal( 0, @silo.level )

    @universe.step
    @silo.reload
    assert( @silo.job.instance_of?( S2C::Models::Jobs::Upgrade ) )
    assert_equal( 0, @silo.job.ticks_remain )
    assert_equal( 0, @silo.level )

    @universe.step
    @silo.reload
    assert_equal( nil, @silo.job )
    assert_equal( 1, @silo.level )
  end

end