require_relative "../test_helper"

class TravelTest < Test::Unit::TestCase

  def setup
    @planet       = S2C::Models::Planet.new( [1, 1] )
    @destination  = S2C::Models::Planet.new( [1, 2] )
    @unit         = S2C::Models::Unit.new( @planet )

    S2C::Utils.expects( :travel_ticks ).with( @planet, @destination, 1 ).returns( 1 )

    @travel =
      S2C::Jobs::Travel.new(
        :unit         => @unit,
        :callback     => :callback_method,
        :destination  => @destination
      )
  end

  def test_initialize
    assert_equal( @unit,            @travel.unit )
    assert_equal( :callback_method, @travel.callback )
    assert_equal( @destination,     @travel.destination )
    assert_equal( 1,                @travel.ticks_total )
    assert_equal( 1,                @travel.ticks_remain )
  end

  def test_step
    @travel.ticks_remain = 2
    @unit.expects( :callback_method ).never

    @travel.step

    assert_equal( 1, @travel.ticks_remain )
  end

  def test_step_finish
    @travel.ticks_remain = 1
    @unit.expects( :callback_method ).once

    @travel.step

    assert_equal( 0, @travel.ticks_remain )
  end

end
