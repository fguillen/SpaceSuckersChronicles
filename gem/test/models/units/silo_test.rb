require_relative "../../test_helper"

class SiloTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 2] )
    @silo   = S2C::Models::Units::Silo.create!( :base => @planet )
  end

  def test_setup
    assert_equal( true,     @silo.job.nil? )
    assert_equal( @silo,    @planet.silo )
    assert_equal( @planet,  @silo.base )
    assert_equal( 2000,     @silo.capacity )
    assert_equal( 0,        @silo.level )
    assert_equal( "silo",   @silo.name )
  end

  def test_start_upgrade
    assert_difference "S2C::Models::Jobs::Upgrade.count", 1 do
      @silo.start_upgrade
    end

    assert_equal( "upgrade",    @silo.job.name )
    assert_equal( @silo,        @silo.job.unit )
    assert_equal( :end_upgrade, @silo.job.callback )
    assert_equal( 1,            @silo.job.ticks_total )
    assert_equal( 1,            @silo.job.ticks_remain )
  end

  def test_end_upgrade
    @silo.end_upgrade

    @silo.reload

    assert_equal( true,   @silo.job.nil? )
    assert_equal( 1,      @silo.level )
    assert_equal( 2010,   @silo.capacity )
  end
end