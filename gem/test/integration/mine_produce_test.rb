require_relative '../test_helper'

class MineProduceTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet     = @universe.planets.create!( :position => [1, 1] )
    @silo       = @planet.create_silo!
    @mine       = @planet.create_mine!
  end

  def test_setup
    assert_equal( 3,    @universe.units.size )
    assert_equal( nil,  @mine.job )
    assert_equal( 1000, @planet.stuff )
  end

  def test_produce
    @mine.start_produce
    @mine.reload
    @planet.reload

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 1000, @planet.stuff )

    @universe.step
    @mine.reload
    @planet.reload

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 1010, @planet.stuff )
  end

  def test_no_produce_if_silo_full
    S2C::Models::Units::Silo.any_instance.stubs( :capacity ).returns( 1002 )

    @mine.start_produce
    @mine.reload
    @planet.reload

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 1000, @planet.stuff )

    @universe.step
    @mine.reload
    @planet.reload

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 1002, @planet.stuff )

    @universe.step
    @mine.reload
    @planet.reload

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 1002, @planet.stuff )
  end

end