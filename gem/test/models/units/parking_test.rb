require_relative "../../test_helper"

class ParkingTest < Test::Unit::TestCase

  def setup
    super

    @planet   = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @parking  = S2C::Models::Units::Parking.create!( :base => @planet )
  end

  def test_setup
    assert_equal( true,       @parking.job.nil? )
    assert_equal( @parking,   @planet.parking )
    assert_equal( @planet,    @parking.base )
    assert_equal( 10,         @parking.capacity )
    assert_equal( 0,          @parking.level )
    assert_equal( "parking",  @parking.name )
  end

  def test_start_upgrade
    assert_difference "S2C::Models::Jobs::Upgrade.count", 1 do
      @parking.start_upgrade
    end

    assert_equal( "upgrade", @parking.job.name )
    assert_equal( @parking, @parking.job.unit )
    assert_equal( :end_upgrade, @parking.job.callback )
    assert_equal( 1, @parking.job.ticks_total )
    assert_equal( 1, @parking.job.ticks_remain )
  end

  def test_end_upgrade
    @parking.job = S2C::Models::Jobs::Upgrade.create!( :unit => @parking, :callback => :callback )

    assert_difference "S2C::Models::Jobs::Upgrade.count", -1 do
      @parking.end_upgrade
    end

    @parking.reload

    assert_equal( true, @parking.job.nil? )
    assert_equal( 1, @parking.level )
    assert_equal( 20, @parking.capacity )
  end

  def test_full
    9.times { @planet.ships.create! }
    assert_equal( false, @parking.full? )

    @planet.ships.create!
    assert_equal( true, @parking.full? )
  end
end