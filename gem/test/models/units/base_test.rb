require_relative "../../test_helper"

class BaseTest < Test::Unit::TestCase

  def setup
    super

    @universe  = S2C::Global.universe
    @base_unit = S2C::Models::Units::Base.create!
  end

  def test_setup
    assert_equal( @universe, @base_unit.universe )
  end

  def test_work_when_no_job
    @base_unit.work
  end

  def test_work_when_job
    job = mock()
    @base_unit.stubs( :job ).returns( job )

    @base_unit.expects( :end_job ).never
    job.stubs( :finish? ).returns( false )
    job.expects( :step )


    @base_unit.work
  end

  def test_work_when_job_finish
    job = mock()
    @base_unit.stubs( :job ).returns( job )

    @base_unit.expects( :end_job ).once
    job.stubs( :finish? ).returns( true )
    job.expects( :step ).never

    @base_unit.work
  end

  def test_end_job
    job = mock()
    job.stubs( :callback ).returns( :callback )
    @base_unit.stubs( :job ).returns( job )

    job.expects( :destroy )
    @base_unit.expects( :callback )

    @base_unit.end_job
  end

end