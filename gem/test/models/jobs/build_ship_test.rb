require_relative "../../test_helper"

class BuildShipTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @hangar = S2C::Models::Units::Hangar.create!( :base => @planet )

    @build_ship =
      S2C::Models::Jobs::BuildShip.create!(
        :unit     => @hangar,
        :callback => :callback
      )

    @build_ship.reload
  end

  def test_setup
    assert_equal( @hangar,      @build_ship.unit )
    assert_equal( :callback,    @build_ship.callback )
    assert_equal( 2,            @build_ship.ticks_total )
    assert_equal( 2,            @build_ship.ticks_remain )
    assert_equal( "build_ship", @build_ship.name )
    assert_equal( 10,           @build_ship.cost )
  end

  def test_step
    @build_ship.ticks_remain = 2
    @build_ship.step
    assert_equal( 1, @build_ship.ticks_remain )
  end

  def test_finish
    @build_ship.ticks_remain = 0
    assert_equal( true, @build_ship.finish? )
  end

  def test_calculate_cost
    assert_equal( 10, @build_ship.calculate_cost )
  end

end
