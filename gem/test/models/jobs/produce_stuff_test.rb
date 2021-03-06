require_relative "../../test_helper"

class ProduceStuffTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @mine   = S2C::Models::Units::Mine.create!( :base => @planet )

    @produce_stuff =
      S2C::Models::Jobs::ProduceStuff.create!(
        :unit     => @mine,
        :callback => :callback
      )

    @produce_stuff.reload
  end

  def test_setup
    assert_equal( @mine,            @produce_stuff.unit )
    assert_equal( :callback,        @produce_stuff.callback )
    assert_equal( "produce_stuff",  @produce_stuff.name )
    assert_equal( 0,                @produce_stuff.cost )
  end

  def test_step
    @produce_stuff.unit.expects( :callback )
    @produce_stuff.step
  end

  def test_finish
    assert_equal( false, @produce_stuff.finish? )
  end

end
