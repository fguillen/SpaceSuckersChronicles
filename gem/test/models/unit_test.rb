require_relative "../test_helper"

class UnitTest < Test::Unit::TestCase
  def setup
    @universe = S2C::Universe.new
    @planet   = S2C::Builder.planet( @universe, [1, 1] )
  end

  def test_initialize
    unit = S2C::Models::Unit.new( @planet )

    assert_not_nil( unit.id )
    assert_equal( @planet,  unit.planet )
    assert_equal( 0,        unit.level )
    assert_equal( nil,      unit.job )
  end

  def test_work_when_job_is_nil
    unit = S2C::Models::Unit.new( @planet )
    unit.work
  end

  def test_work_when_job_is_not_nil
    unit = S2C::Models::Unit.new( @planet )

    job_mock = mock()
    job_mock.expects( :step )

    unit.instance_variable_set( :@job, job_mock )

    unit.work
  end
end