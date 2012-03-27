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
    assert_equal( 10,       @silo.capacity )
    assert_equal( 0,        @silo.level )
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
    @silo.job = S2C::Models::Jobs::Upgrade.create!( :unit => @silo )

    assert_difference "S2C::Models::Jobs::Upgrade.count", -1 do
      @silo.end_upgrade
    end

    @silo.reload

    assert_equal( true, @silo.job.nil? )
    assert_equal( 1,    @silo.level )
    assert_equal( 20,   @silo.capacity )
  end

  def test_full
    @planet.stuff = 9
    assert_equal( false, @silo.full? )

    @planet.stuff = 10
    assert_equal( true, @silo.full? )
  end
end