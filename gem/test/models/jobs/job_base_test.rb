require_relative "../../test_helper"

class JobBaseTest < Test::Unit::TestCase

  def setup
    super

    @planet = S2C::Models::Units::Planet.create!( :position => [1, 1] )
    @unit   = S2C::Models::Units::Base.create!( :base => @planet )
    @job    = S2C::Models::Jobs::Base.new( :unit => @unit, :callback => :callback )
  end

  def test_initialize
    assert_equal( @unit,     @job.unit )
    assert_equal( :callback, @job.callback )
  end

  def test_charge
    @job.stubs( :calculate_cost ).returns( 10 )

    @planet.stuff = 11
    assert_equal( 11, @planet.stuff )

    @job.save!
    assert_equal( 1, @planet.stuff )
  end

  def test_validate_cost
    @job.stubs( :calculate_cost ).returns( 10 )

    @planet.stuff = 10
    assert_equal( true, @job.valid? )

    @planet.stuff = 9
    assert_equal( false, @job.valid? )
    assert_equal( "Not enough stuff, needed: 10", @job.errors[:cost].first )
  end

end
