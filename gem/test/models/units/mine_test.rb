require_relative "../../test_helper"

class MineTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @mine   = S2C::Models::Units::Mine.create!( :base => @planet )
  end

  def test_setup
    assert_equal( true, @mine.job.nil? )
    assert_equal( @mine, @planet.mine )
    assert_equal( @planet, @mine.base )
    assert_equal( 10, @mine.production )
    assert_equal( 0, @mine.level )
  end

  def test_start_produce
    assert_difference "S2C::Models::Jobs::ProduceStuff.count", 1 do
      @mine.start_produce
    end

    assert_equal( "produce", @mine.job.name )
    assert_equal( @mine, @mine.job.unit )
    assert_equal( :produce, @mine.job.callback )
  end

  def test_produce
    @planet.expects( :add_stuff ).with( 10 )
    @mine.produce
  end

  def test_start_upgrade
    assert_difference "S2C::Models::Jobs::Upgrade.count", 1 do
      @mine.start_upgrade
    end

    assert_equal( "upgrade", @mine.job.name )
    assert_equal( @mine, @mine.job.unit )
    assert_equal( :end_upgrade, @mine.job.callback )
    assert_equal( 1, @mine.job.ticks_total )
    assert_equal( 1, @mine.job.ticks_remain )
  end

  def test_end_upgrade
    @mine.job = S2C::Models::Jobs::Upgrade.create!( :unit => @mine, :callback => :callback )

    assert_difference "S2C::Models::Jobs::Upgrade.count", -1 do
      @mine.end_upgrade
    end

    assert_equal( "produce", @mine.job.name )
    assert_equal( 1, @mine.level )
    assert_equal( 20, @mine.production )
  end
end