require_relative '../test_helper'

class MineProduceTest < Test::Unit::TestCase

  def setup
    super

    @universe   = S2C::Global.universe
    @planet     = S2C::Global.store.create_planet( [1, 1] )
    @silo       = S2C::Global.store.create_silo( @planet )
    @mine       = S2C::Global.store.create_mine( @planet )

    @mine.stubs( :id ).returns( "mine" )
    @mine.stubs( :production ).returns( 1 )
  end

  def test_setup
    assert_equal( 3, @universe.units.size )
    assert_equal( nil, @mine.job )
    assert_equal( 0, @silo.stuff )
  end

  def test_produce
    @mine.start_produce

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 0, @silo.stuff )

    @universe.step

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 1, @silo.stuff )
  end

  def test_no_produce_if_silo_full
    @silo.stubs( :capacity ).returns( 0 )

    @mine.start_produce

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 0, @silo.stuff )

    @universe.step

    assert( @mine.job.instance_of?( S2C::Models::Jobs::ProduceStuff ) )
    assert_equal( 0, @silo.stuff )
  end

end