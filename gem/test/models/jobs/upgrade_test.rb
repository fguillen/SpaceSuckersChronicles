require_relative "../../test_helper"

class UpgradeTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @mine   = S2C::Models::Units::Mine.create!( :base => @planet )

    @upgrade =
      S2C::Models::Jobs::Upgrade.create!(
        :unit       => @mine,
        :callback   => :callback
      )

    @upgrade.reload
  end

  def test_setup
    assert_equal( @mine,      @upgrade.unit )
    assert_equal( :callback,  @upgrade.callback )
    assert_equal( 1,          @upgrade.ticks_total )
    assert_equal( 1,          @upgrade.ticks_remain )
    assert_equal( "upgrade",  @upgrade.name )
  end

  def test_step
    @upgrade.ticks_remain = 2
    @upgrade.step
    assert_equal( 1, @upgrade.ticks_remain )
  end

  def test_finish
    @upgrade.ticks_remain = 0
    assert_equal( true, @upgrade.finish? )
  end

end
