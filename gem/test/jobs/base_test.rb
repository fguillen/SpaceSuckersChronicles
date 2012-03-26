require_relative "../test_helper"

class BaseTest < Test::Unit::TestCase

  def setup
    super

    @job = S2C::Models::Jobs::Base.new( "unit", "callback" )
  end

  def test_initialize
    assert_equal( "unit",     @job.unit )
    assert_equal( "callback", @job.callback )
  end

end
