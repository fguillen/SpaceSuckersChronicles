require_relative "../../test_helper"

class JobBaseTest < Test::Unit::TestCase

  def setup
    super

    @unit = S2C::Models::Units::Base.create!
    @job = S2C::Models::Jobs::Base.create!( :unit => @unit, :callback => :callback )
  end

  def test_initialize
    @job.reload
    assert_equal( @unit,     @job.unit )
    assert_equal( :callback, @job.callback )
  end

end
