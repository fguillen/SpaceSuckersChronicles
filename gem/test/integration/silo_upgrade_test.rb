require_relative '../test_helper'

class SiloUpgradeTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet     = S2C::Global.store.create_planet( [1, 1] )
    @silo       = S2C::Global.store.create_silo( @planet )

    @silo.stubs( :id ).returns( "silo" )
  end

  def test_setup
    assert_equal( 2, @universe.units.size )
    assert_equal( nil, @silo.job )
    assert_equal( 1, @silo.level )
  end

  def test_upgrade
    @silo.start_upgrade

    assert( @silo.job.instance_of?( S2C::Models::Jobs::Upgrade ) )
    assert_equal( 1, @silo.job.ticks_remain )
    assert_equal( 1, @silo.level )

    @universe.step

    assert_equal( nil, @silo.job )
    assert_equal( 2, @silo.level )
  end

end