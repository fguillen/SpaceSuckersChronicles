require_relative "../../test_helper"

class TravelTest < Test::Unit::TestCase

  def setup
    super

    @planet  = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @target  = S2C::Models::Units::Planet.create!( :position => [1, 10] )
    @fleet   = S2C::Models::Units::Fleet.create!( :base => @planet, :target => @target )

    @travel =
      S2C::Models::Jobs::Travel.create!(
        :unit       => @fleet,
        :callback   => :callback,
        :target     => @target
      )

    @travel.reload
  end

  def test_setup
    assert_equal( @fleet,     @travel.unit )
    assert_equal( :callback,  @travel.callback )
    assert_equal( @target,    @travel.target )
    assert_equal( 9,          @travel.ticks_total )
    assert_equal( 9,          @travel.ticks_remain )
    assert_equal( "travel",   @travel.name )
  end

  def test_step
    @travel.ticks_remain = 2
    @travel.step
    assert_equal( 1, @travel.ticks_remain )
  end

  def test_finish
    @travel.ticks_remain = 0
    assert_equal( true, @travel.finish? )
  end

end
